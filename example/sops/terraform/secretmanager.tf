resource "aws_secretsmanager_secret" "sops_test" {
  name                    = "${local.name_prefix}/test"
  description             = "${local.name_prefix} SOPS test"
  recovery_window_in_days = 0

  tags = {
    Name = "${local.name_prefix}-sops-test"
  }
}

# SOPS data source to read encrypted secrets
data "sops_file" "secrets" {
  source_file = "secrets.yaml"
}

resource "aws_secretsmanager_secret_version" "sops_test" {
  secret_id     = aws_secretsmanager_secret.sops_test.id
  secret_string = jsonencode(data.sops_file.secrets.data)
}
