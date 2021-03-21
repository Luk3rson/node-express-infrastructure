################################################################################################
# CodeDeploy application
################################################################################################
module "codedeploy_naming" {
  source      = "../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_codedeploy_role_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_codedeploy_app" "app" {
  count            = var.enabled ? 1 : 0
  compute_platform = var.compute_platform
  name             = module.codedeploy_naming.id
}

################################################################################################
# CodeDeploy deployment group
################################################################################################
module "codedeploy_group_naming" {
  source      = "../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_codedeploy_role_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = local.naming_cd_group_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_codedeploy_deployment_group" "deployment_group" {
  count                  = var.enabled ? 1 : 0
  app_name               = aws_codedeploy_app.app[count.index].name
  deployment_group_name  = module.codedeploy_group_naming.id
  service_role_arn       = var.service_role_arn
  autoscaling_groups     = var.autoscaling_groups
  deployment_config_name = var.deployment_config_name

  dynamic "alarm_configuration" {
    for_each = length(var.alarm_configuration) > 0 ? var.alarm_configuration : []
    content {
      alarms                    = alarm_configuration.value.alarms
      enabled                   = alarm_configuration.value.enabled
      ignore_poll_alarm_failure = alarm_configuration.value.ignore_poll_alarm_failure
    }
  }

  dynamic "auto_rollback_configuration" {
    for_each = length(var.auto_rollback_configuration) > 0 ? var.auto_rollback_configuration : []
    content {
      enabled = auto_rollback_configuration.value.enabled
      events  = auto_rollback_configuration.value.events
    }
  }

  dynamic "blue_green_deployment_config" {
    for_each = length(var.blue_green_deployment_config) > 0 ? var.blue_green_deployment_config : []
    content {
      dynamic "deployment_ready_option" {
        for_each = length(blue_green_deployment_config.value.deployment_ready_option) > 0 ? blue_green_deployment_config.value.deployment_ready_option : []
        content {
          action_on_timeout    = deployment_ready_option.value.action_on_timeout
          wait_time_in_minutes = deployment_ready_option.value.wait_time_in_minutes
        }
      }

      dynamic "green_fleet_provisioning_option" {
        for_each = length(blue_green_deployment_config.value.green_fleet_provisioning_option) > 0 ? blue_green_deployment_config.value.green_fleet_provisioning_option : []
        content {
          action = green_fleet_provisioning_option.value.action
        }
      }

      dynamic "terminate_blue_instances_on_deployment_success" {
        for_each = length(blue_green_deployment_config.value.terminate_blue_instances_on_deployment_success) > 0 ? blue_green_deployment_config.value.terminate_blue_instances_on_deployment_success : []
        content {
          action                           = terminate_blue_instances_on_deployment_success.value.action
          termination_wait_time_in_minutes = terminate_blue_instances_on_deployment_success.value.termination_wait_time_in_minutes
        }
      }

    }
  }

  dynamic "deployment_style" {
    for_each = length(var.deployment_style) > 0 ? var.deployment_style : []
    content {
      deployment_option = deployment_style.value.deployment_option
      deployment_type   = deployment_style.value.deployment_type
    }
  }

  dynamic "ecs_service" {
    for_each = length(var.ecs_service) > 0 ? var.ecs_service : []
    content {
      cluster_name = ecs_service.value.cluster_name
      service_name = ecs_service.value.service_name
    }
  }

  dynamic "load_balancer_info" {
    for_each = length(var.load_balancer_info) > 0 ? var.load_balancer_info : []
    content {
      dynamic "elb_info" {
        for_each = length(load_balancer_info.value.elb_info) > 0 ? load_balancer_info.value.elb_info : []
        content {
          name = elb_info.value.name
        }
      }

      dynamic "target_group_info" {
        for_each = length(load_balancer_info.value.target_group_info) > 0 ? load_balancer_info.value.target_group_info : []
        content {
          name = target_group_info.value.name
        }
      }

      dynamic "target_group_pair_info" {
        for_each = length(load_balancer_info.value.target_group_pair_info) > 0 ? load_balancer_info.value.target_group_pair_info : []
        content {
          dynamic "prod_traffic_route" {
            for_each = length(target_group_pair_info.value.prod_traffic_route) > 0 ? target_group_pair_info.value.prod_traffic_route : []
            content {
              listener_arns = prod_traffic_route.value.listener_arns
            }
          }
          dynamic "target_group" {
            for_each = length(target_group_pair_info.value.target_group) > 0 ? target_group_pair_info.value.target_group : []
            content {
              name = target_group.value.name
            }
          }
          dynamic "test_traffic_route" {
            for_each = length(target_group_pair_info.value.test_traffic_route) > 0 ? target_group_pair_info.value.test_traffic_route : []
            content {
              listener_arns = test_traffic_route.value.listener_arns
            }
          }
        }
      }
    }
  }

  dynamic "trigger_configuration" {
    for_each = length(var.trigger_configuration) > 0 ? var.trigger_configuration : []
    content {
      trigger_events     = trigger_configuration.value.trigger_events
      trigger_name       = trigger_configuration.value.trigger_name
      trigger_target_arn = trigger_configuration.value.trigger_target_arn
    }
  }
}