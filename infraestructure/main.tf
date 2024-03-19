#   # Networking resources creation   #   # #

module "networking" {
  source         = "./modules/networking"
  ip             = "186.86.52.118/32"
  region         = var.region
  env            = var.env
  cidr_block_vpc = "10.0.0.0/16"
  subnet_public  = ["10.0.1.0/24", "10.0.2.0/24"]
  subnet_private = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "ecs_role" {
  source    = "./modules/iam"
  name = "ecsTaskExecutionRole_${var.env}"
}

resource "aws_ecr_repository" "ecr_repo" {
  name                 = "ecr-${var.env}"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecs_cluster" "cluster" {
  name = "cluster_${var.env}"
}

### Security group for ECS Tasks
resource "aws_security_group" "sg_ecs_tasks" {
  name        = "sg_ecs_${var.env}"
  description = "controls access to the ecs tasks"
  vpc_id      = module.networking.vpc_id
  tags = {
    Name = "sg_ecs_${var.env}"
  }
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


module "ecs_task_definition" {
  depends_on     = [aws_ecr_repository.ecr_repo]
  source         = "./modules/ecs/taskdefinition"
  task_name      = "task_def_${var.env}"
  task_role      = module.ecs_role.arn_role
  arn_role       = module.ecs_role.arn_role
  cpu            = 512
  memory         = "1024"
  docker_repo    = aws_ecr_repository.ecr_repo.repository_url
  container_port = 5000
  region         = "us-east-1"
}