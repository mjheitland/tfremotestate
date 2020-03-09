#--- test/main.tf ---

# terraform init --backend-config=backend.hcl

provider "aws" {
  profile = "default"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_s3_bucket" "s3_bucket_tfstate" {
  bucket = "tfstate-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  # prevent accidental deletion of this bucket
  # (if you really have to destroy this bucket, change this value to false and reapply)
  lifecycle {
    prevent_destroy = true
  }

  # enable versioning so we can see the full revision history of our state file
  versioning {
    enabled = true
  }

  # enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "dynamodb_table_tfstate" {
  name = "tfstate-${data.aws_region.current.name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}