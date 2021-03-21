################################################################################################
# ECS Cluster task definition
################################################################################################
module "ecs_task_definition_naming" {
  source      = "../../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_ecs_task_role_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_ecs_task_definition" "task_definition" {
  count = var.enabled ? 1 : 0

  family                   = module.ecs_task_definition_naming.id
  container_definitions    = var.container_definitions
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.execution_role_arn
  network_mode             = var.network_mode
  ipc_mode                 = var.ipc_mode
  pid_mode                 = var.pid_mode
  cpu                      = var.cpu
  memory                   = var.memory
  requires_compatibilities = var.requires_compatibilities
  tags                     = module.ecs_task_definition_naming.tags

  dynamic "volume" {
    for_each = length(var.docker_volumes) > 0 ? var.docker_volumes : {}
    content {
      name = volume.key
      docker_volume_configuration {
        scope         = volume.value.scope
        autoprovision = volume.value.autoprovision
        driver        = volume.value.driver
        driver_opts   = volume.value.driver_opts
        labels        = volume.value.labels
      }
    }
  }

  dynamic "volume" {
    for_each = length(var.efs_volumes) > 0 ? var.efs_volumes : {}
    content {
      name = volume.key
      efs_volume_configuration {
        file_system_id = volume.value.file_system_id
        root_directory = volume.value.root_directory
      }
    }
  }

  dynamic "placement_constraints" {
    for_each = length(var.placement_constraints) > 0 ? var.placement_constraints : []
    content {
      type       = placement_constraints.value.type
      expression = placement_constraints.value.expression
    }
  }

  dynamic "proxy_configuration" {
    for_each = length(var.proxy_configuration) > 0 ? var.proxy_configuration : []
    content {
      container_name = proxy_configuration.value.container_name
      properties     = proxy_configuration.value.properties
      type           = proxy_configuration.value.type
    }
  }

  dynamic "inference_accelerator" {
    for_each = length(var.inference_accelerator) > 0 ? var.inference_accelerator : []
    content {
      device_name = inference_accelerator.value.device_name
      device_type = inference_accelerator.value.device_type
    }
  }
}
