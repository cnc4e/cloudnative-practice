resource "aws_security_group" "guardduty_vpc_endpoint" {
  name        = "${local.name_prefix}-guardduty-vpc-endpoint"
  description = "Security group for GuardDuty VPC endpoint"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.name_prefix}-guardduty-vpc-endpoint"
  }
}

resource "aws_vpc_endpoint" "guardduty" {
  vpc_id              = data.terraform_remote_state.network.outputs.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.guardduty-data"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = data.terraform_remote_state.network.outputs.private_subnet_ids
  security_group_ids  = [aws_security_group.guardduty_vpc_endpoint.id]
  private_dns_enabled = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "*"
        Resource  = "*"
        Effect    = "Allow"
        Principal = "*"
      },
      {
        Effect    = "Deny"
        Principal = "*"
        Condition = {
          StringNotEquals = {
            "aws:PrincipalAccount" = "${data.aws_caller_identity.current.account_id}"
          }
        }
        Action   = "*"
        Resource = "*"
      }
    ]
  })

  tags = {
    Name = "${local.name_prefix}-guardduty-vpc-endpoint"
  }
}
