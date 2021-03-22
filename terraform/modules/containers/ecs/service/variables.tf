variable "enabled" {
  type        = bool
  description = "Create a new ecs task definition"
}

variable "name" {
  type        = string
  description = "The name of the ECS Service"
}

variable "capacity_provider_strategy" {
  description = "The capacity provider strategy to use for the service. Can be one or more"
  type = list(object({
    capacity_provider = string
    weight            = number
    base              = number
  }))
}

variable "deployment_controller" {
  description = "Configuration block containing deployment controller configuration"
  type = list(object({
    type = string
  }))
}

variable "load_balancer" {
  description = "A load balancer assosicated with a service"
  type = list(object({
    elb_name         = string
    target_group_arn = string
    container_name   = string
    container_port   = number
  }))
}

variable "network_configuration" {
  description = "The network configuration for the service. This parameter is required for task definitions that use the awsvpc network mode to receive their own Elastic Network Interface, and it is not supported for other network modes"
  type = list(object({
    subnets          = list(string)
    security_groups  = list(string)
    assign_public_ip = bool
  }))
}

variable "ordered_placement_strategy" {
  description = "Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence"
  type = list(object({
    type  = string
    field = string
  }))
}

variable "placement_constraints" {
  description = "Rules that are taken into consideration during task placement"
  type = list(object({
    type       = string
    expression = string
  }))
}

variable "service_registries" {
  description = "The service discovery registries for the service"
  type = list(object({
    registry_arn   = string
    port           = number
    container_port = number
    container_name = string
  }))
}


variable "cluster" {
  description = "ARN of an ECS cluster"
  type        = string
}

variable "deployment_maximum_percent" {
  description = "The upper limit (as a percentage of the services desiredCount) of the number of running tasks that can be running in a service during a deployment"
  type        = number
}

variable "deployment_minimum_healthy_percent" {
  description = "The lower limit (as a percentage of the services desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment"
  type        = number
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running. Defaults to 0. Do not specify if using the DAEMON scheduling strategy"
  type        = number
}

variable "enable_ecs_managed_tags" {
  description = "Specifies whether to enable Amazon ECS managed tags for the tasks within the service"
  type        = bool
}

variable "force_new_deployment" {
  description = "Enable to force a new task deployment of the service. This can be used to update tasks to use a newer Docker image with same image/tag combination (e.g. myimage:latest), roll Fargate tasks onto a newer platform version, or immediately deploy ordered_placement_strategy and placement_constraints updates"
  type        = bool
}

variable "health_check_grace_period_seconds" {
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers"
  type        = number
}

variable "iam_role" {
  description = " ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. This parameter is required if you are using a load balancer with your service, but only if your task definition does not use the awsvpc network mode"
  type        = string
}

variable "launch_type" {
  description = "The launch type on which to run your service. The valid values are EC2 and FARGATE"
  type        = string
}

variable "platform_version" {
  description = "The platform version on which to run your service. Only applicable for launch_type set to FARGATE"
  type        = string
}

variable "propagate_tags" {
  description = "Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION"
  type        = string
}

variable "scheduling_strategy" {
  description = "The scheduling strategy to use for the service. The valid values are REPLICA and DAEMON. Defaults to REPLICA"
  type        = string
}

variable "task_definition" {
  description = "The family and revision (family:revision) or full ARN of the task definition that you want to run in your service"
  type        = string
}