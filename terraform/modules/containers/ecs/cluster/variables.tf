################################################################################################
# ECS Cluster variables locals
################################################################################################
variable "enabled" {
  type        = bool
  description = "Create a new ecs cluster"
}

variable "capacity_providers" {
  type        = list(string)
  description = "List of short names of one or more capacity providers to associate with the cluster. Valid values also include FARGATE and FARGATE_SPOT"
}

variable "default_capacity_provider_strategy" {
  type = list(object({
    capacity_provider_short_name = string
    weight                       = number
    base                         = number
  }))
  description = "The capacity provider strategy to use by default for the cluster. Can be one or more. "
}

variable "settings" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "The capacity provider strategy to use by default for the cluster. Can be one or more. "
}
