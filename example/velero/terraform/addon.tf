resource "aws_eks_addon" "snapshot_controller" {
  cluster_name         = data.terraform_remote_state.eks.outputs.eks_cluster_name
  addon_name           = "snapshot-controller"
  addon_version        = "v8.3.0-eksbuild.1"
  configuration_values = file("setting.json")
  # resolve_conflicts_on_create = ""
  resolve_conflicts_on_update = "OVERWRITE"
}
