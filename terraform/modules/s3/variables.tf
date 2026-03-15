variable "bucket_name_prefix" {
  description = "Prefix used to build the S3 bucket name."
  type        = string
}

variable "name_tag" {
  description = "Value for the Name tag on the bucket."
  type        = string
  default     = "My Example Bucket"
}

variable "environment" {
  description = "Environment tag value for the bucket."
  type        = string
  default     = "Dev"
}

variable "tags" {
  description = "Additional tags to attach to the bucket."
  type        = map(string)
  default     = {}
}

variable "enable_versioning" {
  description = "Enable or suspend S3 versioning."
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Allow deleting bucket even if it contains objects."
  type        = bool
  default     = false
}

variable "block_public_acls" {
  description = "Block public ACLs on this bucket."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Block public bucket policies on this bucket."
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignore public ACLs on this bucket."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restrict public buckets from this account."
  type        = bool
  default     = true
}

variable "sse_algorithm" {
  description = "S3 server-side encryption algorithm."
  type        = string
  default     = "AES256"
}
