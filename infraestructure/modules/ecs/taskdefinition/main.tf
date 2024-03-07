# terraform code to create a task definition 

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.task_name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.arn_role
  task_role_arn            = var.task_role
  container_definitions    = <<DEFINITION
[
  {
    "cpu": 0,
    "image": "${var.registry}",
    "name": "Container-${var.task_name}",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${var.container_port},
        "hostPort": ${var.container_port}
      }
    ]
  }
]
DEFINITION
}
