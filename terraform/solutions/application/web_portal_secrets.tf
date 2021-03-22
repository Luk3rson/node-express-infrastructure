#defaults
locals {
  description     = null
  type            = "SecureString"
  value           = "notworking"
  tier            = "Standard"
  key_id          = data.aws_kms_key.managed_ssm_key.key_id
  overwrite       = false
  allowed_pattern = null
  data_type       = "text"
  tags            = {}
}

data "aws_kms_key" "managed_ssm_key" {
  key_id = "alias/aws/ssm"
}

module "web_portal_docdb_user" {
  source = "../../modules/security/parameter_store_secret"

  name            = join("_", [terraform.workspace, "web_portal_docdb_user"])
  description     = local.description
  type            = local.type
  value           = local.value
  tier            = local.tier
  key_id          = local.key_id
  overwrite       = local.overwrite
  allowed_pattern = local.allowed_pattern
  data_type       = local.data_type

  tags = local.tags
}