variable "name_prefix" {
  type        = string
  description = "Prefix name for our resources."
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for our VPC."
}

variable "public_subnet_count" {
  type        = number
  description = "Count of public subnets to create."

  validation {
    condition     = var.public_subnet_count > 1 && var.public_subnet_count < 3
    error_message = "Number of public subnets created should be between 1 and 3."
  }
}