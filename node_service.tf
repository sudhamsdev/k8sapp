resource "aws_ecs_service" "node_service" {
  name            = var.node_service_name
  cluster         = data.aws_ecs_cluster.ecs_cluster_name.cluster_name
  task_definition = aws_ecs_task_definition.node_servce_task.arn
  desired_count   = 1
  network_configuration {
    subnets         = data.aws_subnets.private_subnets.ids
    security_groups = [aws_security_group.node_service_sg.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cw_policy_attach,
    aws_iam_role_policy_attachment.ecr_policy_attach,
    aws_iam_role_policy_attachment.ssm_policy_attach,
    aws_lb.react_alb,
    aws_lb_target_group.app_rjs_tg,
    aws_lb_target_group.app_njs_tg,
    aws_ecs_task_definition.node_servce_task
  ]

  load_balancer {
    target_group_arn = aws_lb_target_group.app_njs_tg.arn
    container_name   = var.node_container_name
    container_port   = 8000
  }
}