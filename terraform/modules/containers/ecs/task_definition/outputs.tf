output "arn" {
  value       = aws_ecs_task_definition.task_definition.*.arn
  description = "Full ARN of the Task Definition (including both family and revision)"
}

output "family" {
  value       = aws_ecs_task_definition.task_definition.*.family
  description = "The family of the Task Definition"
}

output "revision" {
  value       = aws_ecs_task_definition.task_definition.*.revision
  description = "The revision of the task in a particular family"
}

