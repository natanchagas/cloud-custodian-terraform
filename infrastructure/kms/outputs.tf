output "kms_alias" {
    value = aws_kms_alias.cloud_custodian_key_alias.name
}