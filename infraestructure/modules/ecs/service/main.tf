#   #   AWS SECURITY GROUP ECS  #   #

resource "aws_security_group" "ecs_sg" {
  name   = "ecs-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_service" "ecs_service" {
  name                              = var.name
  cluster                           = var.ecs_cluster_id
  task_definition                   = var.arn_task_definition
  desired_count                     = var.desired_tasks
 # health_check_grace_period_seconds = 10
  launch_type                       = "FARGATE"
  network_configuration {
    security_groups = [aws_security_group.ecs_sg.id]
    subnets         = var.subnet_ids
  }
}
