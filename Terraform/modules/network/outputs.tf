output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.terra.id
}

output "public_subnet_ids" {
  description = "IDs of the subnets created."
  value       = aws_subnet.public[*].id
}