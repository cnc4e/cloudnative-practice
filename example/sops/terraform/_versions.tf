terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
    sops = {
      source  = "carlpett/sops"
      version = "~> 1.0"
    }
  }

  backend "s3" {
    bucket         = "cn-practice-tfstate"
    key            = "sops.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "cn-practice-tfstate"
    encrypt        = true
  }
}

provider "aws" {
  region = local.region
  default_tags {
    tags = {
      project = "cn-practice",
      owner   = "mori"
    }
  }
}

provider "sops" {}
