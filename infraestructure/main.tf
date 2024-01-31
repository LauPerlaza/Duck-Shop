#   # Networking resources creation   #   # #

module "networking" {
  source         = "./modules/networking"
  ip             = "190.5.196.156/32"
  region         = var.region
  env            = var.env
  cidr_block_vpc = "10.0.0.0/16"
  subnet_public  = ["10.0.1.0/24", "10.0.2.0/24"]
  subnet_private = ["10.0.3.0/24", "10.0.4.0/24"]
}