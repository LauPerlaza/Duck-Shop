

#   #   AWS ECS SERVICE  #   #
resource "aws_ecs_service" "ecs_service" {
  name                              = var.service_name
  cluster                           = var.ecs_cluster_id
  task_definition                   = var.arn_task_definition
  desired_count                     = var.desired_tasks
  launch_type                       = "FARGATE"
  network_configuration {
    security_groups = [var.arn_security_group]
    subnets         = var.subnet_ids
  }
}
