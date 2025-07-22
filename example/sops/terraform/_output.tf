output "kms_key_id" {
  description = "KMS key ID for SOPS"
  value       = aws_kms_key.sops.key_id
}

output "kms_key_arn" {
  description = "KMS key ARN for SOPS"
  value       = aws_kms_key.sops.arn
}
