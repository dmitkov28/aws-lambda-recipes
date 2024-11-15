resource "aws_lambda_function" "go_func" {
  function_name = var.function_name
  role          = aws_iam_role.lambda_role.arn
  package_type  = "Zip"
  filename      = "../code/func.zip"
  runtime       = "provided.al2023"
  handler       = "bootstrap"
  timeout       = 60
  memory_size   = 512

}

resource "aws_lambda_function_url" "lambda_function_url" {
  function_name      = aws_lambda_function.go_func.function_name
  authorization_type = "NONE"
}

resource "aws_iam_role" "lambda_role" {
  name = var.function_role

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
