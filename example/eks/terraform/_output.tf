output "eks_cluster_name" {
  value       = aws_eks_cluster.this.name
  description = "EKSクラスタ名"
}

output "ebs_encryption_key_id" {
  value       = aws_kms_key.ebs_encryption.key_id
  description = "EBS暗号化用KMSキーID"
}

output "ebs_encryption_key_arn" {
  value       = aws_kms_key.ebs_encryption.arn
  description = "EBS暗号化用KMSキーARN"
}
