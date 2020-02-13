#--- test/main.tf ---

provider "aws" {
  region = var.region
  profile = "default"
}

# terraform init --backend-config=../backend.hcl
terraform {
  backend "s3" {
    key = "mymodule/terraform.tfstate"
  }
}

resource "aws_s3_bucket" "s3_bucket_mybucket" {
  bucket = "mjh-mybucket"

  # prevent accidental deletion of this bucket
  # (if you really have to destroy this bucket, change this value to false and reapply)
  lifecycle {
    prevent_destroy = false
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
  tags = { 
    project_name = var.project_name
  }
}
