################################################################################################
# CodeDeploy application variables
################################################################################################
variable "enabled" {
  type        = bool
  description = "Create a new codebuild project"
}

variable "compute_platform" {
  type        = string
  description = "The compute platform can either be ECS, Lambda, or Server"
}

################################################################################################
# CodeDeploy deployment group
################################################################################################
variable "service_role_arn" {
  type        = string
  description = "The service role ARN that allows deployments"
}

variable "autoscaling_groups" {
  type        = list(string)
  description = "Autoscaling groups associated with the deployment group"
}

variable "deployment_config_name" {
  type        = string
  description = "The name of the group's deployment config"
}

variable "alarm_configuration" {
  type = list(object({
    alarms                    = list(string)
    enabled                   = bool
    ignore_poll_alarm_failure = bool
  }))
  description = "Configuration block of alarms associated with the deployment group"
}

variable "auto_rollback_configuration" {
  type = list(object({
    enabled = bool
    events  = list(string)
  }))
  description = "Configuration block of the automatic rollback configuration associated with the deployment group"
}

variable "blue_green_deployment_config" {
  type = list(object({
    deployment_ready_option = list(object({
      action_on_timeout    = string
      wait_time_in_minutes = number
    }))
    green_fleet_provisioning_option = list(object({
      action = string
    }))
    terminate_blue_instances_on_deployment_success = list(object({
      action                           = string
      termination_wait_time_in_minutes = number
    }))
  }))
  description = "Configuration block of the blue/green deployment options for a deployment group"
}

variable "deployment_style" {
  type = list(object({
    deployment_option = string
    deployment_type   = string
  }))
  description = "Configuration block of the type of deployment, either in-place or blue/green, you want to run and whether to route deployment traffic behind a load balancer"
}

variable "ecs_service" {
  type = list(object({
    cluster_name = string
    service_name = string
  }))
  description = "Configuration block(s) of the ECS services for a deployment group"
}

variable "load_balancer_info" {
  type = list(object({
    elb_info = list(object({
      name = string
    }))
    target_group_info = list(object({
      name = string
    }))
    target_group_pair_info = list(any)
  }))
  description = "Single configuration block of the load balancer to use in a blue/green deployment"
}

variable "trigger_configuration" {
  type = list(object({
    trigger_events     = list(string)
    trigger_name       = string
    trigger_target_arn = string
  }))
  description = "Configuration block(s) of the triggers for the deployment group"
}