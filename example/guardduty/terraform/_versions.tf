terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1"
    }
  }

  backend "s3" {
    bucket         = "cn-practice-tf-state"
    key            = "guardduty/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "cn-practice-tf-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-northeast-2"

  default_tags {
    tags = {
      Project = "cn-practice"
      Owner   = "mori"
    }
  }
}