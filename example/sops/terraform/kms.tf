resource "aws_kms_key" "sops" {
  description             = "KMS key for SOPS encryption"
  deletion_window_in_days = 7
  
  tags = {
    Name = "${local.name_prefix}-sops"
  }
}

