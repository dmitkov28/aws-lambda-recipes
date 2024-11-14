terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.75.1"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}


data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_ecr_authorization_token" "token" {}

module "publisher" {
  source    = "./publisher"
  queue_url = module.sqs.sqs_queue_url
  queue_arn = module.sqs.sqs_queue_arn
}

module "subscriber" {
  source = "./subscriber"

  queue_url = module.sqs.sqs_queue_url
  queue_arn = module.sqs.sqs_queue_arn
}

module "sqs" {
  source = "./sqs"
}
