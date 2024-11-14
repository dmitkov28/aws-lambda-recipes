resource "aws_lambda_function" "subscriber_function" {
  function_name = var.subscriber_function_name
  architectures = [var.subscriber_function_arch]
  role          = aws_iam_role.subscriber_function_role.arn
  filename      = "../lambda_subscriber/func.zip"
  runtime       = "python3.12"
  handler       = "main.lambda_handler"
  timeout     = 60
  memory_size = 512


}

resource "aws_iam_role" "subscriber_function_role" {
  name = var.subscriber_function_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "subscriber_function_sqs_policy" {
  name = "lambda_sqs_policy"
  role = aws_iam_role.subscriber_function_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:SendMessageBatch"
        ]
        Resource = var.queue_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.subscriber_function_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
