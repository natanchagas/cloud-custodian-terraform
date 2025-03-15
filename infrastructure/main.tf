data "aws_caller_identity" "current" {}

module "custodian_schedule_role" {
  source = "./iam"

  role = {
    name         = "cloud-custodian-role"
    trust_policy = templatefile("iam/trust-templates/scheduler-trust-policy.json", {})
  }

  policy = {
    name   = "cloud-custodian-policy"
    policy = templatefile("iam/policy-templates/scheduler-policy.json", {})
  }
}

module "custodian_lambda_role" {
  source = "./iam"

  role = {
    name         = "cloud-custodian-lambda-role"
    trust_policy = templatefile("iam/trust-templates/lambda-trust-policy.json", {})
  }

  policy = {
    name   = "cloud-custodian-lambda-policy"
    policy = templatefile("iam/policy-templates/lambda-policy.json", {})
  }
}

module "sqs" {
  source = "./sqs"
}

module "kms" {
  source = "./kms"
}

resource "aws_scheduler_schedule_group" "cloud_custodian_schedule_group" {
  name = "cloud-custodian-schedule-group"
}

module "scheduler" {
  source = "./scheduler"

  schedule_group_name = aws_scheduler_schedule_group.cloud_custodian_schedule_group.name
  schedule_role       = module.custodian_schedule_role.role_arn

  kms_key_arn = module.kms.kms_arn

  target_arn = module.sqs.sqs_arn
}