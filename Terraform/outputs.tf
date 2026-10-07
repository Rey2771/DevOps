output "website_url" {
  description = "Public URL of the web server."
  value       = "http://${module.web_server.public_ip}"
}

output "vpc_id" {
  description = "ID of the created VPC."
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the subnets created."
  value       = module.network.public_subnet_ids
}

output "instance_id" {
  description = "Instance ID of the EC2."
  value       = module.web_server.instance_id
}