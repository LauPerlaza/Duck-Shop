terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}
#   #   # AWS PROVIDER #  #   #
provider "aws" {
  region                   = var.region
  shared_credentials_files = ["~/.aws/credentials"]
}