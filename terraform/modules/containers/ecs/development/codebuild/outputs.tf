output "id" {
  value       = aws_codebuild_project.codebuild.*.id
  description = "The name (if imported via name) or ARN (if created via Terraform or imported via ARN) of the CodeBuild project"
}

output "arn" {
  value       = aws_codebuild_project.codebuild.*.arn
  description = "The ARN of the CodeBuild project"
}

