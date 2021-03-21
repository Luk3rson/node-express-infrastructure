######################################################
# Security group resource
######################################################

output "sg_id" {
  value       = aws_security_group.secgroup.id
  description = "Security geoup ID"
}

output "sg_arn" {
  value       = aws_security_group.secgroup.arn
  description = "Security geoup ARN"
}

