variable "publisher_function_name" {
  description = "Name of Publisher Lambda"
  type        = string
  default     = "publisher"
}

variable "publisher_function_role" {
  description = "Role Name of Publisher Lambda"
  type        = string
  default     = "PublisherLambdaRole"
}

variable "publisher_function_arch" {
  description = "Architecture of the Publisher Lambda"
  type        = string
  default     = "arm64"
}


variable "queue_url" {
  type = string
}

variable "queue_arn" {
  type = string
}