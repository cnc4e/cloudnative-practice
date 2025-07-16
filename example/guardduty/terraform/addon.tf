resource "aws_eks_addon" "guardduty_agent" {
  cluster_name  = data.terraform_remote_state.eks.outputs.eks_cluster_name
  addon_name    = "aws-guardduty-agent"
  addon_version = "v1.10.0-eksbuild.2"
}
