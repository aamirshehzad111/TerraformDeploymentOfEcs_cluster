terraform {
  backend "s3" {
    bucket = "terraform-state-preserver-bucket-by-aamir11"
    key = "global/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-ecs-projet11"
    encrypt = true

  }

}

resource "aws_dynamodb_table" "terraform_lock" {
  hash_key = "LockID"
  name     = "terraform-ecs-projet11"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}