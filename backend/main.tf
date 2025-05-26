terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "aniket-tf-state-lockin-adv"

  tags = {
    Name        = "tf-state-lockin"
    Environment = "dev"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "terraform-state-lockin-adv"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "tf-state-lockin"
    Environment = "dev"
  }
}
