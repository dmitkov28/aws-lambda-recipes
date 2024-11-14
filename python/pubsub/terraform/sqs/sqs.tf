resource "aws_sqs_queue" "terraform_queue" {
  name                      = var.sqs_name
  visibility_timeout_seconds = 60
}