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

module "aws_ecr" {
  source = "./modules/ecr"
  ecr_name   = "ecr_${var.env}"
}

module "ecs_role" {
  source    = "./modules/iam"
  role_name = "ecs_role_${var.env}"
}

resource "aws_ecs_cluster" "cluster" {
  name = "cluster_${var.env}"
}

module "ecs_task_definition" {
  source         = "./modules/ecs/taskdefinition"
  task_name      = "task_def_${var.env}"
  task_role      = module.ecs_role.arn_role
  arn_role       = module.ecs_role.arn_role
  cpu            = 512
  memory         = "1024"
  registry       = module.aws_ecr.ecr_arn
  region         = var.region
  container_port = 5000
}

module "aws_ecs_service" {
  source              = "./modules/ecs/service"
  service_name        = "ecs_service_${var.env}"
  ecs_cluster_id      = aws_ecs_cluster.cluster.id
  arn_task_definition = module.ecs_task_definition.arn_task_definition
  desired_tasks       = 1
  vpc_id              = module.networking.vpc_id
  subnet_ids          = [module.networking.sub_pub_1, module.networking.sub_pub_2]
}