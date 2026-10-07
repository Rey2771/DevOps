# Creating an S3 bucket that stores the main project's Terraform state
terraform {
  # Stating the Terraform version that we need to be used
  required_version = ">= 1.10.0"

  # Mention the providers we need, based on the tools used
  required_providers {
    # Infrastructure built on AWS, so we mention the aws provider block here
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    # Provider which generates values randomly
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "tf-webapp"
      Purpose   = "terraform-state"
      ManagedBy = "Terraform"
    }
  }
}

variable "aws_region" {
  type        = string
  description = "Region to place our state bucket in."
  default     = "ap-southeast-2"
}

# Creating a randomized ID to attach as suffix to our S3 bucket as the name of the S3 bucket must be unique
resource "random_id" "suffix" {
  byte_length = 4
}

# Creating the S3 bucket to store the state file
resource "aws_s3_bucket" "state" {
  # Attaching the randomized suffix generated to our bucket name to make it unique
  bucket = "tf-aws-webapp-${random_id.suffix.hex}"

  # Prevents the s3 bucket from getting destroyed accidentally
  lifecycle {
    prevent_destroy = true
  }
}

# Versioning enabled so that every version of the state file is stored
resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# State file can contain potentially sensitive information in plain text, so encrypts the file at rest with AES-256
resource "aws_s3_bucket_server_side_encryption_configuration" "state" {
  bucket = aws_s3_bucket.state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Blocking all four kinds of public access
resource "aws_s3_bucket_public_access_block" "state" {
  bucket = aws_s3_bucket.state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Generates the final bucket name as output
output "state_bucket_name" {
  description = "State bucket name"
  value       = aws_s3_bucket.state.bucket
}