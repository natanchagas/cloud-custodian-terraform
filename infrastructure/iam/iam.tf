resource "aws_iam_role" "role" {
    name = var.role.name

    assume_role_policy = var.role.trust_policy
}

resource "aws_iam_policy" "policy" {
    name = var.policy.name
    path = "/"
    policy = var.policy.policy
}

resource "aws_iam_policy_attachment" "attachment" {
    name       = "attachment"
    roles      = [aws_iam_role.role.name]
    policy_arn = aws_iam_policy.policy.arn
}