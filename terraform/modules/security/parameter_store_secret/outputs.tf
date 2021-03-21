
output "arn" {
    description = "The ARN of the parameter"
    value = aws_ssm_parameter.secret.arn
}

output "name" {
    description = "The name of the parameter"
    value = aws_ssm_parameter.secret.name
}

output "description" {
    description = "The description of the parameter"
    value = aws_ssm_parameter.secret.description
}

output "type" {
    description = "The type of the parameter. Valid types are String, StringList and SecureString"
    value = aws_ssm_parameter.secret.type
}

output "value" {
    description = "The value of the parameter"
    value = aws_ssm_parameter.secret.value
}