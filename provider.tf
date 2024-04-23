terraform {
  backend "s3" {
    bucket         = "657694663228-terraform-tfstate-2024"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-tfstate-lock-2024"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}
