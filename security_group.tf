resource "aws_security_group" "alb_sg" {
  name        = var.alb_sg_name
  description = "Security Group to allow Ingress and Egress traffic on ALB"
  vpc_id      = data.aws_vpc.ecs_vpc.id
}

resource "aws_security_group" "node_service_sg" {
  name        = var.node_svc_sg_name
  description = "Security Group to allow Ingress and Egress traffic to ECS task"
  vpc_id      = data.aws_vpc.ecs_vpc.id
}

resource "aws_security_group" "react_service_sg" {
  name        = var.react_svc_sg_name
  description = "Security Group to allow Ingress and Egress traffic to ECS task"
  vpc_id      = data.aws_vpc.ecs_vpc.id
}