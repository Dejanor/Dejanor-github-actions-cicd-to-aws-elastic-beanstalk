terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = ">= 4.0"  
  }

  backend "s3" {
    region         = "eu-west-2"
    bucket         = "winich-devops"
    key            = "winich/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-west-2"
}
