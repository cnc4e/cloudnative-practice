# EKS Autopilot クラスター
resource "aws_eks_cluster" "this" {
  name                          = local.name_prefix
  role_arn                      = aws_iam_role.cluster.arn
  version                       = "1.32"
  bootstrap_self_managed_addons = false

  access_config {
    authentication_mode = "API"
  }

  compute_config {
    enabled       = true
    node_pools    = ["general-purpose","system"]
    node_role_arn = aws_iam_role.node.arn
  }

  kubernetes_network_config {
    elastic_load_balancing {
      enabled = true
    }
  }

  storage_config {
    block_storage {
      enabled = true
    }
  }

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = local.eks_public_access_cidrs

    subnet_ids = concat(
      data.terraform_remote_state.network.outputs.public_subnet_ids,
      data.terraform_remote_state.network.outputs.private_subnet_ids
    )
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSComputePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSBlockStoragePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSLoadBalancingPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSNetworkingPolicy,
  ]


  tags = {
    Name = local.name_prefix
  }
}

# Terraform実行ユーザーのEKSアクセスエントリー
resource "aws_eks_access_entry" "current_user" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = data.aws_caller_identity.current.arn
  type          = "STANDARD"
}

# Terraform実行ユーザーのEKSアクセス権限付与
resource "aws_eks_access_policy_association" "current_user_admin" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = data.aws_caller_identity.current.arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}
