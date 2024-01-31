# terraform code to create a task definition that use secret manager 

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "task-definition-${var.name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.arn_role
  task_role_arn            = var.task_role
  container_definitions    = <<DEFINITION
            [
              {
                "logConfiguration": {
                    "logDriver": "awslogs",
                    "secretOptions": null,
                    "options": {
                      "awslogs-group": "/ecs/taks-${var.env}",
                      "awslogs-region": "${var.region}",
                      "awslogs-stream-prefix": "ecs"
                    }
                  },
                "cpu": 0,
                "image": "${var.registry}",
                "name": "Container-${var.name}",
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

