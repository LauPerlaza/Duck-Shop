terraform {

  backend "s3" {
    bucket = "${BUCKET_NAME}" #"web-ducks-server-develop"
    key = "${STATE_KEY}" #"web-ducks-server-develop"
    region = "${AWS_REGION}" #"us-east-1"
    dynamodb_table = "${DYNAMODB_TABLE}" #"dynamodb-ducks-develop"
    encrypt = true
   }
}