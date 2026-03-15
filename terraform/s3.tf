terraform {
  required_version = ">= 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "example_bucket" {
  source = "./modules/s3"

  bucket_name_prefix = var.bucket_name_prefix
  name_tag           = var.name_tag
  environment        = var.environment
  tags               = var.tags
}

variable "aws_region" {
  description = "AWS region where the S3 bucket will be created."
  type        = string
  default     = "eu-west-1ß"
}

variable "bucket_name_prefix" {
  description = "Prefix used to build the S3 bucket name."
  type        = string
  default     = "my-example-bucket"
}

variable "name_tag" {
  description = "Value for the Name tag on the S3 bucket."
  type        = string
  default     = "My Example Bucket"
}

variable "environment" {
  description = "Environment tag value for the S3 bucket."
  type        = string
  default     = "Dev"
}

variable "tags" {
  description = "Additional tags to apply to the bucket."
  type        = map(string)
  default     = {}
}

output "bucket_name" {
  description = "Name of the created S3 bucket."
  value       = module.example_bucket.bucket_name
}

output "bucket_arn" {
  description = "ARN of the created S3 bucket."
  value       = module.example_bucket.bucket_arn
}