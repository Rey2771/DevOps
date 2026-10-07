variable "aws_region" {
  type        = string
  description = "Region to deploy our web-app into"
  default     = "ap-southeast-2"
}

variable "project_name" {
  type        = string
  description = "Name used to prefix and tag all resources"
  default     = "tf-webapp"
}

variable "environment" {
  type        = string
  description = "Deployment environment"
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of the three: prod, dev or staging."
  }
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block of the VPC"
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR must be a valid IPv4 CIDR block, such as 10.0.0.0/16"
  }
}

variable "public_subnet_count" {
  type        = number
  description = "Number of public subnets, spread across all AZs"
  default     = 2
}

variable "instance_type" {
  type        = string
  description = "Instance type of the EC2 server"
  default     = "t3.micro"
}

variable "allowed_http_cidrs" {
  type        = list(string)
  description = "CIDR blocks allowed to reach the website over HTTP"
  default     = ["0.0.0.0/0"]
}