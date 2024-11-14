variable "subscriber_function_name" {
  description = "Name of Subscriber Lambda"
  type        = string
  default     = "subscribe"
}

variable "subscriber_function_role" {
  description = "Role Name of Subscriber Lambda"
  type        = string
  default     = "SubscriberLambdaRole"
}

variable "subscriber_function_arch" {
  description = "Architecture of the Subscriber Lambda"
  type        = string
  default     = "arm64"
}

variable "queue_url" {
  type = string
}

variable "queue_arn" {
  type = string
}

