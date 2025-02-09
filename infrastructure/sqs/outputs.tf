output sqs_arn {
    value = aws_sqs_queue.cloud_custodian_queue.arn
}