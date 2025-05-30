locals {
  name_prefix = "cn-practice"
  region      = "ap-northeast-2"
  vpc_cidr    = "10.0.0.0/16"

  public_subnets = {
    "a" = "10.0.0.0/24",
    "b" = "10.0.1.0/24",
    "c" = "10.0.2.0/24"
  }

  private_subnets = {
    "a" = "10.0.10.0/24",
    "b" = "10.0.11.0/24",
    "c" = "10.0.12.0/24"
  }
}
