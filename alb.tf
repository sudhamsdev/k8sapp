resource "aws_lb" "react_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = data.aws_subnets.public_subnets.ids
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.alb_sg.id]

  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true

  tags = merge(
    local.common_tags,
    {
      Name = "k8sengineersapp"
    }
  )
}

resource "aws_lb_listener" "redirect_listener" {
  load_balancer_arn = aws_lb.react_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      host        = "k8sdevops.in"
      status_code = "HTTP_301"
    }
  }

  depends_on = [
    aws_lb.react_alb
  ]
}

resource "aws_lb_listener" "rjs_listener" {
  load_balancer_arn = aws_lb.react_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:438894829072:certificate/e87fc278-21c1-40a9-a934-2c6d6ba30002"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_rjs_tg.arn
  }

  depends_on = [
    aws_lb.react_alb
  ]
}

resource "aws_lb_listener" "njs_listener" {
  load_balancer_arn = aws_lb.react_alb.arn
  port              = "444"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:438894829072:certificate/e87fc278-21c1-40a9-a934-2c6d6ba30002"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_njs_tg.arn
  }

  depends_on = [
    aws_lb.react_alb
  ]
}