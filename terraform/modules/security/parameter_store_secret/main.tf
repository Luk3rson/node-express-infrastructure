resource "aws_ssm_parameter" "secret" {
  name            = var.name
  description     = var.description
  type            = var.type
  value           = var.value
  tier            = var.tier
  key_id          = var.key_id
  overwrite       = var.overwrite
  allowed_pattern = var.allowed_pattern
  //data_type       = var.data_type

  tags = var.tags

  lifecycle {
    ignore_changes = [
     value,
    ]
  }
}