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
  source      = "./modules/iam"
  name_role   = "ducks-${var.env}"
  
}

resource "aws_ecr_repository" "ecr_repo" {
  name                 = "ecr-${var.env}"
  image_tag_mutability = "MUTABLE"
}

# AWS ECR CLUSTER
resource "aws_ecs_cluster" "cluster" {
  name = "cluster-${var.env}"
}

# AWS ECS SERVICE
resource "aws_ecs_service" "ecs_service" {
  name            = "ecs_service"
  cluster         = aws_ecs_cluster.cluster.arn
  task_definition = module.ecs_task_definition.task_definition_arn

  network_configuration {
    subnets          = [module.networking.sub_priv_1, module.networking.sub_priv_2]
    security_groups  = [aws_security_group.sg_ecs_tasks.id]
    assign_public_ip = "false"
  }

}

# Security group for ECS Tasks
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
  execution_role = module.ecs_role.arn_executionrole
  cpu            = 512
  memory         = "1024"
  docker_repo    = aws_ecr_repository.ecr_repo.repository_url
  container_port = 5000
  region         = "us-east-1"
}

module "kms_secret_manager" {
  source = "./modules/secret-manager"
  name = "secretsm_${var.env}"

}
