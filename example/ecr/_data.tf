# Terraform実行アカウントの情報取得（DenyOtherAccountsの自アカウントID判定に使用）
data "aws_caller_identity" "current" {}

# CI/CD用ロール（push許可の対象）
data "aws_iam_role" "runner" {
  name = "${local.name_prefix}-actions-runner-role"
}

# EKSノード用ロール（pull専用許可の対象）
data "aws_iam_role" "eks_node" {
  name = "${local.name_prefix}-eks-node-role"
}
