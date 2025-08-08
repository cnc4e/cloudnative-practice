terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1"
    }
  }

  backend "s3" {
    bucket       = "cn-practice-tfstate"
    key          = "actions.tfstate"
    region       = "ap-northeast-2"
    use_lockfile = true
    encrypt      = true
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
