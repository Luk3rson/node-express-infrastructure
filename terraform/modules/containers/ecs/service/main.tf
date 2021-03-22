################################################################################################
# ECS Cluster Service
################################################################################################
module "ecs_service_naming" {
  source      = "../../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_ecs_service_role_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_ecs_service" "service" {
  count                              = var.enabled ? 1 : 0
  name                               = var.name
  cluster                            = var.cluster
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  desired_count                      = var.desired_count
  enable_ecs_managed_tags            = var.enable_ecs_managed_tags
  force_new_deployment               = var.force_new_deployment
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  iam_role                           = var.iam_role
  launch_type                        = var.launch_type
  platform_version                   = var.platform_version
  propagate_tags                     = var.propagate_tags
  scheduling_strategy                = var.scheduling_strategy
  task_definition                    = var.task_definition

  dynamic "capacity_provider_strategy" {
    for_each = length(var.capacity_provider_strategy) > 0 ? var.capacity_provider_strategy : []
    content {
      capacity_provider = capacity_provider_strategy.value.capacity_provider
      weight            = capacity_provider_strategy.value.weight
      base              = capacity_provider_strategy.value.base
    }
  }

  dynamic "deployment_controller" {
    for_each = length(var.deployment_controller) > 0 ? var.deployment_controller : []
    content {
      type = deployment_controller.value.type
    }
  }

  dynamic "load_balancer" {
    for_each = length(var.load_balancer) > 0 ? var.load_balancer : []
    content {
      elb_name         = load_balancer.value.elb_name
      target_group_arn = load_balancer.value.target_group_arn
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
    }
  }

  dynamic "network_configuration" {
    for_each = length(var.network_configuration) > 0 ? var.network_configuration : []
    content {
      subnets          = network_configuration.value.subnets
      security_groups  = network_configuration.value.security_groups
      assign_public_ip = network_configuration.value.assign_public_ip
    }
  }

  dynamic "ordered_placement_strategy" {
    for_each = length(var.ordered_placement_strategy) > 0 ? var.ordered_placement_strategy : []
    content {
      type  = ordered_placement_strategy.value.type
      field = ordered_placement_strategy.value.field
    }
  }

  dynamic "placement_constraints" {
    for_each = length(var.placement_constraints) > 0 ? var.placement_constraints : []
    content {
      type       = placement_constraints.value.type
      expression = placement_constraints.value.expression
    }
  }

  dynamic "service_registries" {
    for_each = length(var.service_registries) > 0 ? var.service_registries : []
    content {
      registry_arn   = service_registries.value.registry_arn
      port           = service_registries.value.port
      container_port = service_registries.value.container_port
      container_name = service_registries.value.container_name
    }
  }

  lifecycle {
        ignore_changes = ["platform_version", "task_definition", "load_balancer"]
  }

}