terraform {

  backend "s3" {
    bucket = "tf-state-ducks-develop"
    key = "Tfstate-ducks-server" 
    region = "us-east-1"
    dynamodb_table = "dynamodb-ducks-develop"
    encrypt = true  
    ECR_REGISTRY_URI = "658299583140.dkr.ecr.us-east-1.amazonaws.com/duck-shop-0.1"
   }
}