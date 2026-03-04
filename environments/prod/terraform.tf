terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.31.0"
    }
  }
  backend "s3" {
    bucket         = "multi-env-statelock-bucket"
    key            = "prod/terraform.tfstate"   
    region         = "ap-south-1"
    dynamodb_table = "multi-env-statelock-table"
    encrypt        = true
  }
}