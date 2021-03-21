output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = module.vpc.vpc_cidr_block
}


output "jenkins_subnets" {
  description = "List of Jenkins subnets"
  value       = module.jenkins_subnet.subnet_id
}

output "public_subnets" {
  description = "List of Jenkins subnets"
  value       = module.public_subnet.subnet_id
}

output "availability_zones" {
  value       = var.azs
  description = "List of used availability zones per subnet"
}

output "database_subnets" {
  description = "List of Database subnets"
  value       = module.database_subnet.subnet_id
}

output "application_subnets" {
  description = "List of Application subnets"
  value       = module.application_subnet.subnet_id
}

output "nat_gateway_ip" {
  description = "NAT gateway public ip"
  value = module.natgw.natgw_eip_public_ip
}