# terraform code to create a task definition 

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.task_name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role
  container_definitions    = jsonencode([
    {
      "cpu": 0,
      "image": var.docker_repo,
      "name": "Container-${var.task_name}",
      "networkMode": "awsvpc",
      "portMappings": [
        {
          "containerPort": var.container_port,
          "hostPort": var.container_port
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/TaskDF-${var.task_name}",
          "awslogs-region": var.region,
          "awslogs-create-group": "true",    
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ])
}

# CloudWatch Logs groups to store ecs-containers logs
resource "aws_cloudwatch_log_group" "TaskDF-Log_Group" {
  name              = "/ecs/TaskDF-${var.task_name}"
  retention_in_days = 30
}