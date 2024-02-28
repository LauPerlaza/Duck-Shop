terraform {

  backend "s3" {
    bucket = "tf-state-ducks-develop"
    key = "Tfstate-ducks-server" 
    region = "us-east-1"
    dynamodb_table = "dynamodb-ducks-develop"
    encrypt = true  
   }
}