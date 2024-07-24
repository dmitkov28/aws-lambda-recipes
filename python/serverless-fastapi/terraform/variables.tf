variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "serverless_fastapi"
}

variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "serverless_fastapi_image"
}

variable "api_gateway_name" {
  description = "Name of the API Gateway"
  type        = string
  default     = "serverless_fastapi_gw"
}