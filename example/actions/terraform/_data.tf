data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket  = "cn-practice-tfstate"
    key     = "eks.tfstate"
    region  = "ap-northeast-2"
    encrypt = true
  }
}
