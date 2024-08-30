provider "aws" {
  region = "us-west-1"
}

resource "aws_s3_bucket" "nency_bucket" {
  bucket = "nency-bucket"
  versioning {
    enabled = true
  }

  tags = {
    Name = "nency-s3-bucket"
  }
}

resource "aws_dynamodb_table" "nency_terraform_lock" {
  name           = "nency_terraform_lock-table"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "nency-terraform-lock-table"
  }
}
