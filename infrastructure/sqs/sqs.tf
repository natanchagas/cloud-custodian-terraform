resource "aws_sqs_queue" "cloud_custodian_queue" {
  name                      = "terraform-example-queue"
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
}