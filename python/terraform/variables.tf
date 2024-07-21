variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "python_function"
}

variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "python_image"
}