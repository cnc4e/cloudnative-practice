data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "cn-practice-tfstate"
    key    = "network.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "cn-practice-tfstate"
    key    = "eks.tfstate"
    region = "ap-northeast-2"
  }
}
