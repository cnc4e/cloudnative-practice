# Get subnet IDs from network module tfstate
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "cn-practice-tfstate"
    key    = "network.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "secletmanager" {
  backend = "s3"
  config = {
    bucket = "cn-practice-tfstate"
    key    = "sops/secletmanager.tfstate"
    region = "ap-northeast-2"
  }
}

# Get current user (Terraform execution user)
data "aws_caller_identity" "current" {}
