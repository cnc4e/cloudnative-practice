resource "aws_eks_addon" "snapshot_controller" {
  cluster_name  = data.terraform_remote_state.eks.outputs.eks_cluster_name
  addon_name    = "snapshot-controller"
  addon_version = "v8.3.0-eksbuild.1"
}
