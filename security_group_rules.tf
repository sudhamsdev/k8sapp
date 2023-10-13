# Security group rules for ALB traffic, Ingress and Egress

resource "aws_security_group_rule" "https_ing_rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "http_ing_rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "njs_ing_rule" {
  type              = "ingress"
  from_port         = 444
  to_port           = 444
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "alb_egress_rules" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

# Security group rules for React traffic, Ingress and Egress

resource "aws_security_group_rule" "react_svc_ing_rules" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["10.10.0.0/16"]
  security_group_id = aws_security_group.react_service_sg.id
}

resource "aws_security_group_rule" "react_svc_eg_rules" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.react_service_sg.id
}

# Security group rules for NodeJS traffic, Ingress and Egress

resource "aws_security_group_rule" "node_svc_ing_rules" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "tcp"
  cidr_blocks       = ["10.10.0.0/16"]
  security_group_id = aws_security_group.node_service_sg.id
}

resource "aws_security_group_rule" "node_svc_eg_rules" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.node_service_sg.id
}