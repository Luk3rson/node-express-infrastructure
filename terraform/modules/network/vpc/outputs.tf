output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The ID of the VPC"
}

output "vpc_cidr_block" {
  value       = aws_vpc.this.cidr_block
  description = "The CIDR block of the VPC"
}

output "igw_id" {
  value       = aws_internet_gateway.this[0].id
  description = "Internet gateway ID attached to VPC"
}



