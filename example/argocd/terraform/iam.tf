data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

# ImageUpdater
resource "aws_iam_role" "argocd_imageupdater" {
  name               = "${local.name_prefix}-argo-imageupdater-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "argocd_imageupdater_ecr_readonly" {
  role       = aws_iam_role.argocd_imageupdater.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_eks_pod_identity_association" "argocd_imageupdater" {
  cluster_name    = data.terraform_remote_state.eks.outputs.eks_cluster_name
  namespace       = local.namespace
  service_account = local.service_account
  role_arn        = aws_iam_role.argocd_imageupdater.arn
}

# RepoServer ksops
resource "aws_iam_role" "argocd_repo_server" {
  name               = "${local.name_prefix}-argo-repo-server-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "argocd_repo_server_kms" {
  role       = aws_iam_role.argocd_repo_server.name
  policy_arn = "arn:aws:iam::aws:policy/AWSKeyManagementServicePowerUser"
}

resource "aws_eks_pod_identity_association" "argocd_repo_server" {
  cluster_name    = data.terraform_remote_state.eks.outputs.eks_cluster_name
  namespace       = local.namespace
  service_account = "argocd-repo-server"
  role_arn        = aws_iam_role.argocd_repo_server.arn
}
