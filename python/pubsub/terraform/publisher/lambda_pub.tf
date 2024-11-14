resource "aws_lambda_function" "publisher_function" {
  function_name = var.publisher_function_name
  architectures = [var.publisher_function_arch]
  role          = aws_iam_role.publisher_function_role.arn
  filename      = "../lambda_publisher/func.zip"
  runtime       = "python3.12"
  handler       = "main.lambda_handler"
  timeout       = 60
  memory_size   = 512

  environment {
    variables = {
      QUEUE_URL = var.queue_url
    }
  }

}

resource "aws_iam_role" "publisher_function_role" {
  name = var.publisher_function_role
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

resource "aws_iam_role_policy" "publisher_function_sqs_policy" {
  name = "lambda_sqs_policy"
  role = aws_iam_role.publisher_function_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = var.queue_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.publisher_function_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
