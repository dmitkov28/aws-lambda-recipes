resource "aws_cloudwatch_log_group" "publisher_cloudwatch" {
  name              = "/aws/lambda/${var.subscriber_function_name}_logs"
  retention_in_days = 1
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.subscriber_function_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}