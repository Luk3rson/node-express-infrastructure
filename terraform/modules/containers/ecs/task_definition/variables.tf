################################################################################################
# ECS Cluster task definition variables
################################################################################################
variable "inference_accelerator" {
  type = list(object({
    device_name = string
    device_type = string
  }))
  description = "Definition of interface accelerator - type is list because of usage of dynamic"
}

variable "proxy_configuration" {
  type = list(object({
    container_name = string
    properties     = map(string)
    type           = string
  }))
  description = "Definition of proxy configuration - type is list because of usage of dynamic"
}

variable "placement_constraints" {
  type = list(object({
    type       = string
    expression = string
  }))
  description = "A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10"
}

variable "docker_volumes" {
  type = map(object({
    scope         = string
    autoprovision = bool
    driver        = string
    driver_opts   = map(string)
    labels        = map(string)
  }))
  description = "A set of docker volume blocks that containers in your task may use"
}

variable "efs_volumes" {
  type = map(object({
    type           = string
    file_system_id = string
    root_directory = string
  }))
  description = "A set of efs volume blocks that containers in your task may use"
}

variable "enabled" {
  type        = bool
  description = "Create a new ecs task definition"
}

variable "container_definitions" {
  type        = string
  description = "A list of valid container definitions provided as a single valid JSON document. Please note that you should only provide values that are part of the container definition document."
}

variable "task_role_arn" {
  type        = string
  description = "The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services"
}

variable "network_mode" {
  type        = string
  description = "The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host"
}

variable "ipc_mode" {
  type        = string
  description = "The IPC resource namespace to be used for the containers in the task The valid values are host, task, and none"
}

variable "pid_mode" {
  type        = string
  description = "The process namespace to use for the containers in the task. The valid values are host and task"
}

variable "cpu" {
  type        = number
  description = "The number of cpu units used by the task. If the requires_compatibilities is FARGATE this field is required"
}

variable "memory" {
  type        = number
  description = "The amount (in MiB) of memory used by the task. If the requires_compatibilities is FARGATE this field is required"
}

variable "requires_compatibilities" {
  type        = list(string)
  description = "A set of launch types required by the task. The valid values are EC2 and FARGATE"
}

variable "execution_role_arn" {
  type        = string
  description = "The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume"
}
