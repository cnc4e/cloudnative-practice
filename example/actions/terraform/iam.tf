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
  name               = "${local.name_prefix}-actions-runner-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "actions_runner_ecr_readonly" {
  role       = aws_iam_role.actions_runner.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "actions_runner_aws_readonly" {
  role       = aws_iam_role.actions_runner.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    effect = "Allow"
    
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket"
    ]
    
    resources = ["*"]
  }
}

resource "aws_iam_policy" "s3_access" {
  name   = "${local.name_prefix}-actions-runner-s3-policy"
  policy = data.aws_iam_policy_document.s3_access.json
}

resource "aws_iam_role_policy_attachment" "actions_runner_s3_access" {
  role       = aws_iam_role.actions_runner.name
  policy_arn = aws_iam_policy.s3_access.arn
}

data "aws_iam_policy_document" "sns_publish" {
  statement {
    effect = "Allow"
    
    actions = [
      "sns:Publish"
    ]
    
    resources = ["*"]
  }
}

resource "aws_iam_policy" "sns_publish" {
  name   = "${local.name_prefix}-actions-runner-sns-policy"
  policy = data.aws_iam_policy_document.sns_publish.json
}

resource "aws_iam_role_policy_attachment" "actions_runner_sns_publish" {
  role       = aws_iam_role.actions_runner.name
  policy_arn = aws_iam_policy.sns_publish.arn
}

resource "aws_eks_pod_identity_association" "actions_runner" {
  cluster_name    = data.terraform_remote_state.eks.outputs.eks_cluster_name
  namespace       = local.namespace
  service_account = local.service_account
  role_arn        = aws_iam_role.actions_runner.arn
}

