output "arn" {
  value       = aws_cloudwatch_log_group.log_group.*.arn
  description = "The Amazon Resource Name (ARN) specifying the log group"
}

output "name" {
  value       = module.log_group_naming.id
  description = "Name of the log group"
}
