resource "aws_ecs_task_definition" "node_servce_task" {
  family             = var.node_task_name
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
      "name" : "k8snode",
      "image" : "438894829072.dkr.ecr.us-east-1.amazonaws.com/k8sengineersbackend:1.1.0",
      "portMappings" : [
        {
          "name" : "k8snode-8000-tcp",
          "containerPort" : 8000,
          "hostPort" : 8000,
          "protocol" : "tcp",
          "appProtocol" : "http"
        }
      ],
      "environmentFiles": [
        {
          "value": "arn:aws:s3:::k8sengineers-envfiles/k8sengineers/backend.env",
          "type": "s3"
        }
      ],
      "essential" : true,
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-create-group" : "true",
          "awslogs-group" : "/ecs/k8sengineersnode",
          "awslogs-region" : "us-east-1",
          "awslogs-stream-prefix" : "ecs"
        }
      }
    }
  ])
}