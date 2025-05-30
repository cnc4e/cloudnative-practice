# ネットワーク情報をリモートステートから取得
data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket         = "cn-practice-tfstate"
    key            = "network.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
  }
}

# Terraform実行ユーザーの情報取得
data "aws_caller_identity" "current" {}
