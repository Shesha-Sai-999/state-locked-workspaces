terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.31.0"
    }
  }

  backend "s3" {
    bucket         = "multi-env-statelock-bucket" # Your hardcoded bucket name
    key            = "dev/terraform.tfstate"      # Isolated path for Dev
    region         = "ap-south-1"                  # Your hardcoded region
    dynamodb_table = "multi-env-statelock-table"  # Your hardcoded table name
    encrypt        = true
  }
}