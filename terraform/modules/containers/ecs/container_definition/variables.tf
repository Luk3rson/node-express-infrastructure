################################################################################################
# ECS Container definition variables
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/parameters.html
################################################################################################
variable "dnsSearchDomains" {
  type        = list(string)
  description = "Container definition DNS search domains list"
}

variable "logConfiguration" {
  type = object({
    logDriver     = string
    options       = map(string)
    secretOptions = list(map(string))
  })
  description = "Container definition logs group options"
}


variable "entryPoint" {
  type        = list(string)
  description = "Container definition entry point"
}

variable "portMappings" {
  type = list(object({
    hostPort      = number
    protocol      = string
    containerPort = number
  }))
  description = "Container definition port mapping"
}

variable "command" {
  type        = list(string)
  description = "Container definition command"
}

variable "linuxParameters" {
  type        = any
  description = "Container definition linux parameters"
}

variable "cpu" {
  type        = number
  description = "Container definition CPU units"
}

variable "environment" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "The environment variables to pass to a container"
}

variable "resourceRequirements" {
  type        = list(string)
  description = "Task definistion resource requirements"
}

variable "ulimits" {
  type = list(object({
    name      = string
    softLimit = number
    hardLimit = number
  }))
  description = "Container definition unit limits"
}

variable "dnsServers" {
  type        = list(string)
  description = "Container definition DNS servers"
}

variable "mountPoints" {
  type = list(object({
    sourceVolume  = string
    containerPath = string
    readOnly : bool
  }))
  description = "The mount points for data volumes in your container"
}

variable "workingDirectory" {
  type        = string
  description = "The working directory in which to run commands inside the container"
}

variable "secrets" {
  type = list(object({
    name      = string
    valueFrom = string
  }))
  description = "The secret to expose to your container"
}

variable "dockerSecurityOptions" {
  type        = list(string)
  description = "Container definition docker security options"
}

variable "memory" {
  type        = number
  description = "Container definition memory"
}

variable "memoryReservation" {
  type        = number
  description = "Container definition memory reservation"
}

variable "volumesFrom" {
  type = list(object({
    sourceContainer = string
    readOnly        = bool
  }))
  description = "Data volumes to mount from another container"
}

variable "stopTimeout" {
  type        = number
  description = "Task defintion stop timeout"
}

variable "image" {
  type        = string
  description = "Container definition docker image name"
}

variable "startTimeout" {
  type        = number
  description = "Container definition start timeout"
}

variable "dependsOn" {
  type = list(object({
    containerName = string
    condition     = string
  }))
  description = "The dependencies defined for container startup and shutdown"
}

variable "disableNetworking" {
  type        = bool
  description = "When this parameter is true, networking is disabled within the container"
}

variable "interactive" {
  type        = bool
  description = "When this parameter is true, this allows you to deploy containerized applications that require stdin or a tty to be allocated"
}

variable "healthCheck" {
  type = object({
    command     = list(string)
    interval    = number
    timeout     = number
    retries     = number
    startPeriod = number
  })
  description = "The container health check command and associated configuration parameters for the container."
}

variable "essential" {
  type        = bool
  description = "Container definition essential"
}

variable "links" {
  type        = list(string)
  description = "Container definition link to containers"
}

variable "hostname" {
  type        = string
  description = "Container definition container hostname"
}

variable "extraHosts" {
  type = list(object({
    hostname  = string
    ipAddress = string
  }))
  description = "A list of hostnames and IP address mappings to append to the /etc/hosts file on the container"
}

variable "pseudoTerminal" {
  type        = bool
  description = "When this parameter is true, a TTY is allocated"
}

variable "user" {
  type        = string
  description = "Container definition user"
}

variable "readonlyRootFilesystem" {
  type        = bool
  description = "When this parameter is true, the container is given read-only access to its root file system"
}

variable "dockerLabels" {
  type        = map(string)
  description = "Container definition docker labels"
}

variable "systemControls" {
  type = list(object({
    namespace = string
    value     = string
  }))
  description = "A list of namespaced kernel parameters to set in the container"
}

variable "privileged" {
  type        = bool
  description = "When this parameter is true, the container is given elevated privileges on the host container instance"
}

variable "name" {
  type        = string
  description = "Name of the container"
}
