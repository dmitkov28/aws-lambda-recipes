variable "sqs_name" {
  description = "Name of the SQS Queue"
  type = string
  default = "SQS"
}

variable "sqs_delay" {
    description = "SQS Delay"
    type = number
    default = 90
}