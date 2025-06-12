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

resource "aws_iam_role" "actions_runner" {
  name               = "${local.name_prefix}-argo-imageupdater-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "actions_runner_ecr_readonly" {
  role       = aws_iam_role.actions_runner.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_eks_pod_identity_association" "actions_runner" {
  cluster_name    = data.terraform_remote_state.eks.outputs.eks_cluster_name
  namespace       = local.namespace
  service_account = local.service_account
  role_arn        = aws_iam_role.actions_runner.arn
}

