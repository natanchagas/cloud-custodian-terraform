resource "aws_scheduler_schedule" "cloud_custodian_schedule_0" {
  name       = "cloud-custodian-schedule-0"
  group_name = var.schedule_group_name

  description = "A schedule with KMS key, using a cron expression and a custom schedule group"

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

resource "aws_scheduler_schedule" "cloud_custodian_schedule_1" {
  name       = "cloud-custodian-schedule-1"
  group_name = var.schedule_group_name

    description = "A schedule without KMS key, using a cron expression and a custom schedule group"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "cron(0 0 20 12 ? *)"

  target {
    arn      = var.target_arn
    role_arn = var.schedule_role
  }
}

resource "aws_scheduler_schedule" "cloud_custodian_schedule_2" {
  name       = "cloud-custodian-schedule-2"
  group_name = var.schedule_group_name

  description = "A schedule with KMS key, using a one time schedule expression and a custom schedule group"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "at(2025-12-20T00:00:00)"

  kms_key_arn = var.kms_key_arn

  target {
    arn      = var.target_arn
    role_arn = var.schedule_role
  }
}

resource "aws_scheduler_schedule" "cloud_custodian_schedule_3" {
  name       = "cloud-custodian-schedule-3"

  description = "A schedule with KMS key, using a cron expression and a the default schedule group"

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