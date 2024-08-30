resource "aws_s3_bucket" "nency_bucket" {
  bucket_prefix = var.bucket_prefix

  versioning {
    enabled = true
  }

  tags = {
    Name = "nency-s3-bucket"
  }
}

