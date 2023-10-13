resource "aws_lb_target_group" "app_rjs_tg" {
  name                          = var.rjs_targetgroup_name
  port                          = 80
  protocol                      = "HTTP"
  target_type                   = "ip"
  ip_address_type               = "ipv4"
  vpc_id                        = data.aws_vpc.ecs_vpc.id
  load_balancing_algorithm_type = "round_robin"

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = "200-299,300-399"
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "app_njs_tg" {
  name                          = var.njs_targetgroup_name
  port                          = 8000
  protocol                      = "HTTP"
  target_type                   = "ip"
  ip_address_type               = "ipv4"
  vpc_id                        = data.aws_vpc.ecs_vpc.id
  load_balancing_algorithm_type = "round_robin"

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = "200-299,300-399"
    path                = "/health"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}