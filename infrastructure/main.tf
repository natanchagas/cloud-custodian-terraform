data "aws_caller_identity" "current" {}

module "custodian_eventbridge_role" {
  source = "./iam"

  role = {
    name         = "cloud-custodian-role"
    trust_policy = templatefile("iam/role-templates/ec2-trust-policy.json")
  }

  policy = {
    name   = "cloud-custodian-policy"
    policy = templatefile("iam/policy-templates/ec2-policy.json")
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
  schedule_role       = module.custodian_eventbridge_role.role_arn

  kms_key_arn = module.kms.key_arn

  target_arn = module.sqs.queue_arn
}