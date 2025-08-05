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

resource "aws_iam_role" "atlantis" {
  name               = "${local.name_prefix}-atlantis-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = {
    test = "atlantis-1"
  }
}

resource "aws_iam_role_policy_attachment" "atlantis_admin" {
  role       = aws_iam_role.atlantis.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_eks_pod_identity_association" "atlantis" {
  cluster_name    = data.terraform_remote_state.eks.outputs.eks_cluster_name
  namespace       = local.namespace
  service_account = local.service_account
  role_arn        = aws_iam_role.atlantis.arn
}
