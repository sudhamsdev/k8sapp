resource "aws_ecs_task_definition" "react_servce_task" {
  family             = var.react_task_name
  cpu                = "150"
  memory             = "300"
  execution_role_arn = aws_iam_role.task_role.arn
  task_role_arn      = aws_iam_role.task_role.arn
  network_mode       = "awsvpc"

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  requires_compatibilities = [
    "EC2"
  ]

  container_definitions = jsonencode([
    {
      "name" : "k8sreact",
      "image" : "438894829072.dkr.ecr.us-east-1.amazonaws.com/k8sengineersfrontend:1.1.0",
      "portMappings" : [
        {
          "name" : "k8sreact-80-tcp",
          "containerPort" : 80,
          "hostPort" : 80,
          "protocol" : "tcp",
          "appProtocol" : "http"
        }
      ],
      "environmentFiles": [
        {
          "value": "arn:aws:s3:::k8sengineers-envfiles/k8sengineers/frontend.env",
          "type": "s3"
        }
      ],
      "essential" : true,
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-create-group" : "true",
          "awslogs-group" : "/ecs/k8sengineersreact",
          "awslogs-region" : "us-east-1",
          "awslogs-stream-prefix" : "ecs"
        }
      }
    }
  ])
}