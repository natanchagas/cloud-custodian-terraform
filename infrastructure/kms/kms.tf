data "aws_caller_identity" "current" {}

resource "aws_kms_key" "cloud_custodian_key" {
  description             = "An example symmetric encryption KMS key"

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-default-1"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_kms_alias" "cloud_custodian_key_alias" {
  name          = "alias/cloud_custodian_key"
  target_key_id = aws_kms_key.cloud_custodian_key.key_id
}