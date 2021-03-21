output "natgw_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.this.id
}

output "natgw_eip" {
  description = "Elastic IP attached to NATGW"
  value       = aws_eip.nat.id
}

output "natgw_eip_private_ip" {
  description = "Contains the private IP address"
  value       = aws_eip.nat.private_ip
}

output "natgw_eip_public_ip" {
  description = "Contains the public IP address"
  value       = aws_eip.nat.public_ip
}

