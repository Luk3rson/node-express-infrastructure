output "id" {
  value       = aws_ecs_cluster.ecs.*.id
  description = "The Amazon Resource Name (ARN) that identifies the cluster"
}

output "arn" {
  value       = aws_ecs_cluster.ecs.*.id
  description = "The Amazon Resource Name (ARN) that identifies the cluster"
}

output "name" {
  value       = module.ecs_naming.id
  description = "ECS cluster name"
}