resource "aws_iam_role" "task_role" {
  name = var.task_role_name

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {
          "StringEquals" : {
            "aws:SourceAccount" : "438894829072"
          },
          "ArnLike" : {
            "aws:SourceArn" : "arn:aws:ecs:us-east-1:438894829072:*"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cw_policy_attach" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.cloudwatch.arn
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attach" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.ssm.arn
}

resource "aws_iam_role_policy_attachment" "s3_policy_attach" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.s3_env.arn
}

resource "aws_iam_role_policy_attachment" "ecr_policy_attach" {
  role       = aws_iam_role.task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}