variable "name_prefix" {
  type        = string
  description = "Prefix attached to all our resource names."
}

variable "environment" {
  type        = string
  description = "Type of environment, shown in webpage."
}

variable "vpc_id" {
  type        = string
  description = "VPC to place the security group in."
}

variable "subnet_id" {
  type        = string
  description = "Subnet to launch the instance in."
}

variable "instance_type" {
  type        = string
  description = "Instance type of the EC2 instance."
}

variable "allowed_http_cidrs" {
  type        = list(string)
  description = "CIDR blocks allowed to reach port 80"
}