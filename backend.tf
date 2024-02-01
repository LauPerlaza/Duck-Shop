terraform {

  backend "s3" {
    bucket = "${BUCKET_NAME}" 
    key = "${STATE_KEY}" 
    region = "${AWS_REGION}"
    dynamodb_table = "${DYNAMODB_TABLE}"
    encrypt = true
   }
}