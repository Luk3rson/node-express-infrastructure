output "arn" {
  value       = aws_docdb_cluster.db.*.arn
  description = "Amazon Resource Name (ARN) of cluster"
}

output "cluster_members" {
  value       = aws_docdb_cluster.db.*.cluster_members
  description = "List of DocDB Instances that are a part of this cluster"
}

output "cluster_resource_id" {
  value       = aws_docdb_cluster.db.*.cluster_resource_id
  description = "The DocDB Cluster Resource ID"
}

output "endpoint" {
  value       = aws_docdb_cluster.db.*.endpoint
  description = "The DNS address of the DocDB instance"
}

output "hosted_zone_id" {
  value       = aws_docdb_cluster.db.*.hosted_zone_id
  description = "The Route53 Hosted Zone ID of the endpoint"
}

output "id" {
  value       = aws_docdb_cluster.db.*.id
  description = "The DocDB Cluster Identifier"
}
