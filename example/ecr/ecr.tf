resource "aws_ecr_repository" "backend" {
  name                 = "backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository_policy" "backend" {
  repository = aws_ecr_repository.backend.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowVPCAccess"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = "ecr:*"
        Condition = {
          IpAddress = {
            "aws:SourceIp" = "10.0.0.0/16"
          }
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "frontend" {
  name                 = "frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository_policy" "frontend" {
  repository = aws_ecr_repository.frontend.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowVPCAccess"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = "ecr:*"
        Condition = {
          IpAddress = {
            "aws:SourceIp" = "10.0.0.0/16"
          }
        }
      }
    ]
  })
} 