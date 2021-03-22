output "configuration_group_name" {
  value       = aws_codedeploy_deployment_group.deployment_group.*.id
  description = "Application name and deployment group name"
}