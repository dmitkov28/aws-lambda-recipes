resource "aws_lambda_function" "python_func" {
  function_name = var.function_name
  package_type  = "Image"
  architectures = [local.architecture]
  image_uri     = "${data.aws_ecr_image.python_image.registry_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${data.aws_ecr_image.python_image.repository_name}@${data.aws_ecr_image.python_image.image_digest}"
  role          = aws_iam_role.lambda_role.arn
  timeout       = 60
  memory_size   = 512

  environment {
    variables = {
      AWS_LWA_PORT = 8000
    }
  }

  depends_on = [docker_image.python_image, aws_ecr_repository.ecr_repo]
}

resource "aws_lambda_function_url" "lambda_function_url" {
  function_name      = aws_lambda_function.python_func.function_name
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

# Get the architecture of your local machine
data "external" "uname" {
  program = ["sh", "-c", "echo '{\"arch\": \"'$(uname -m)'\"}'"]
}

locals {
  architecture = data.external.uname.result.arch
}