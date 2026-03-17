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
  region = local.effective_aws_region
}

locals {
  # Terrakube variable values can be empty strings; fallback keeps provider valid.
  effective_aws_region = trimspace(coalesce(var.aws_region, "")) != "" ? trimspace(coalesce(var.aws_region, "")) : "eu-west-1"
}

module "example_bucket" {
  source = "./modules/s3"

  bucket_name_prefix = var.bucket_name_prefix
  name_tag           = var.name_tag
  environment        = var.environment
  tags               = var.tags
}

module "My_Bucket" {
  source = "./modules/s3"

  bucket_name_prefix = var.My_Bucket_name_prefix
  name_tag           = var.My_Bucket_name_tag
  environment        = var.environment
  tags               = var.My_Bucket_tags
}

variable "aws_region" {
  description = "AWS region where the S3 bucket will be created."
  type        = string
  default     = "eu-west-1"

  validation {
    condition     = trimspace(coalesce(var.aws_region, "")) == "" || can(regex("^[a-z]{2}-[a-z]+-[0-9]$", trimspace(coalesce(var.aws_region, ""))))
    error_message = "aws_region must be empty or match a valid region format such as eu-west-1."
  }
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

variable "My_Bucket_name_prefix" {
  description = "Prefix used to build the second S3 bucket name."
  type        = string
  default     = "my-second-example-bucket"
}

variable "My_Bucket_name_tag" {
  description = "Value for the Name tag on the second S3 bucket."
  type        = string
  default     = "My Second Example Bucket"
}

variable "My_Bucket_tags" {
  description = "Additional tags to apply to the second bucket."
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

output "My_Bucket_name" {
  description = "Name of the second created S3 bucket."
  value       = module.My_Bucket.bucket_name
}

output "My_Bucket_arn" {
  description = "ARN of the second created S3 bucket."
  value       = module.My_Bucket.bucket_arn
}