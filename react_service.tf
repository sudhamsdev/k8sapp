resource "aws_ecs_service" "react_service" {
  name            = var.react_service_name
  cluster         = data.aws_ecs_cluster.ecs_cluster_ds.cluster_name
  task_definition = aws_ecs_task_definition.react_servce_task.arn
  desired_count   = 1
  network_configuration {
    subnets         = data.aws_subnets.private_subnets.ids
    security_groups = [aws_security_group.react_service_sg.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cw_policy_attach,
    aws_iam_role_policy_attachment.ecr_policy_attach,
    aws_iam_role_policy_attachment.ssm_policy_attach,
    aws_lb.react_alb,
    aws_lb_target_group.app_rjs_tg,
    aws_lb_target_group.app_njs_tg,
    aws_ecs_task_definition.react_servce_task
  ]

  load_balancer {
    target_group_arn = aws_lb_target_group.app_rjs_tg.arn
    container_name   = var.react_container_name
    container_port   = 80
  }
}