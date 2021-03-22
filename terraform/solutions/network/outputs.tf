
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = module.vpc.vpc_cidr_block
}

output "availability_zones" {
  value       = var.azs
  description = "List of used availability zones per subnet"
}

output "private_subnets" {
  value = module.private-subnet.subnet_id
}

output "public_subnets" {
  value = module.public-subnet.subnet_id
}