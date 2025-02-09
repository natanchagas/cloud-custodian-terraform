resource "aws_scheduler_schedule" "cloud_custodian_schedule" {
  name       = "cloud-custodian-schedule"
  group_name = var.schedule_group_name

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "cron(0 0 20 12 ? *)"

  kms_key_arn = var.kms_key_arn

  target {
    arn      = var.target_arn
    role_arn = var.schedule_role
  }
}