################################################################################################
# ECS Cluster resource
################################################################################################
module "ecs_naming" {
  source      = "../../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_ecs_role_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_ecs_cluster" "ecs" {
  count              = var.enabled ? 1 : 0
  name               = module.ecs_naming.id
  capacity_providers = var.capacity_providers

  dynamic "default_capacity_provider_strategy" {
    for_each = var.default_capacity_provider_strategy
    content {
      capacity_provider = default_capacity_provider_strategy.value.capacity_provider_short_name
      weight            = default_capacity_provider_strategy.value.weight
      base              = default_capacity_provider_strategy.value.base
    }
  }

  dynamic "setting" {
    for_each = var.settings
    content {
      name  = setting.value.name
      value = setting.value.value
    }
  }

  tags = module.ecs_naming.tags

}
