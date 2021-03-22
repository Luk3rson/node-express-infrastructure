################################################################################################
# CloudWatch log group resource
################################################################################################
module "log_group_naming" {
  source      = "../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_log_group_role_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_cloudwatch_log_group" "log_group" {
  count             = var.enabled ? 1 : 0
  name              = module.log_group_naming.id
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_id
  tags              = module.log_group_naming.tags
}


