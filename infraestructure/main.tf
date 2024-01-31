#   # Networking resources creation   #   # #

module "networking" {
  source         = "./modules/networking"
  ip             = "190.5.196.156/32"
  region         = var.region
  env            = var.env
  cidr_block_vpc = "10.0.0.0/16"
  subnet_public  = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "ecr_api_ducks" {
  source = "./modules/ecr"
  name   = "api_ducks"
}

# # Role for ecs tasks #  #
module "ecs_role" {
  source    = "./modules/iam"
  name_role = "lab_${var.env}"
}

# Cluster for ecs #
resource "aws_ecs_cluster" "cluster" {
  name = "cluster_${var.env}"
}

module "task_definition" {
  source         = "./modules/ecs/taskdefinition"
  name           = "ducks_api_tf_${var.env}"
  task_role      = module.ecs_role.arn_role
  arn_role       = module.ecs_role.arn_role
  cpu            = 512
  memory         = "1024"
  registry       = module.ecr_api_ducks.ecr_arn
  region         = var.region
  container_port = 2368
}

module "ecs_service" {
  source              = "./modules/ecs/service"
  name                = "ecs_service_${var.env}"
  ecs_cluster_id      = aws_ecs_cluster.cluster.id
  arn_task_definition = module.task_definition.arn_task_definition
  desired_tasks       = 1
  vpc_id              = module.networking.vpc_id
  subnet_ids          = [module.networking.sub_pub_1, module.networking.sub_pub_2]
}
