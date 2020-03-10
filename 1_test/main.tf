#--- test/main.tf ---

provider "aws" {
  region = var.region
  profile = "default"
}

# terraform init --backend-config=../backend.hcl
terraform {
  backend "s3" {
    key = "1_test/terraform.tfstate"
  }
}

resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  tags = { 
    project_name = var.project_name
  }
}
