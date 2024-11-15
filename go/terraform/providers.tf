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
