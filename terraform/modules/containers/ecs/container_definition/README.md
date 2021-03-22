## Purpose
1. The implementation of ecs container definition json

## Usage example
```
module "container_definition" {
  source                 = "../../modules/containers/ecs/container_definition"
  dnsSearchDomains       = []
  logConfiguration       = {
    logDriver     = "awslogs"
    secretOptions = []
    options = {
      awslogs-group         = log_group_arn,
      awslogs-region        = log_group_region,
      awslogs-stream-prefix = "ecs"
    }
  }
  entryPoint             = []
  portMappings           = []
  command                = []
  linuxParameters        = {}
  cpu                    = 1024
  environment            = [
    {
      name  = "ENVIRONMENT"
      value = "prod"
    }
  ]
  resourceRequirements   = []
  ulimits                = []
  dnsServers             = []
  mountPoints            = []
  workingDirectory       = ""
  secrets                = []
  dockerSecurityOptions  = []
  memory                 = 1024
  memoryReservation      = 0
  volumesFrom            = []
  stopTimeout            = 0
  image                  = docker_image_url
  startTimeout           = 0
  dependsOn              = []
  disableNetworking      = false
  interactive            = false
  healthCheck            = null
  essential              = true
  links                  = []
  hostname               = "foo"
  extraHosts             = []
  pseudoTerminal         = false
  user                   = ""
  readonlyRootFilesystem = false
  dockerLabels           = {}
  systemControls         = []
  privileged             = false
  name                   = "foo_container"
}
```

## Providers

| Name | Version |
|------|---------|
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| command | Container definition command | `list(string)` | n/a | yes |
| cpu | Container definition CPU units | `number` | n/a | yes |
| dependsOn | The dependencies defined for container startup and shutdown | <pre>list(object({<br>    containerName = string<br>    condition = string<br>  }))</pre> | n/a | yes |
| disableNetworking | When this parameter is true, networking is disabled within the container | `bool` | n/a | yes |
| dnsSearchDomains | Container definition DNS search domains list | `list(string)` | n/a | yes |
| dnsServers | Container definition DNS servers | `list(string)` | n/a | yes |
| dockerLabels | Container definition docker labels | `map(string)` | n/a | yes |
| dockerSecurityOptions | Container definition docker security options | `list(string)` | n/a | yes |
| entryPoint | Container definition entry point | `list(string)` | n/a | yes |
| environment | The environment variables to pass to a container | <pre>list(object({<br>    name = string<br>    value = string<br>  }))</pre> | n/a | yes |
| essential | Container definition essential | `bool` | n/a | yes |
| extraHosts | A list of hostnames and IP address mappings to append to the /etc/hosts file on the container | <pre>list(object({<br>    hostname = string<br>    ipAddress = string<br>  }))</pre> | n/a | yes |
| healthCheck | The container health check command and associated configuration parameters for the container. | <pre>object({<br>    command = list(string)<br>    interval = number<br>    timeout = number<br>    retries = number<br>    startPeriod = number<br>  })</pre> | n/a | yes |
| hostname | Container definition container hostname | `string` | n/a | yes |
| image | Container definition docker image name | `string` | n/a | yes |
| interactive | When this parameter is true, this allows you to deploy containerized applications that require stdin or a tty to be allocated | `bool` | n/a | yes |
| links | Container definition link to containers | `list(string)` | n/a | yes |
| linuxParameters | Container definition linux parameters | `any` | n/a | yes |
| logConfiguration | Container definition logs group options | <pre>object({<br>      logDriver = string<br>      options = map(string)<br>      secretOptions = list(map(string))<br>  })</pre> | n/a | yes |
| memory | Container definition memory | `number` | n/a | yes |
| memoryReservation | Container definition memory reservation | `number` | n/a | yes |
| mountPoints | The mount points for data volumes in your container | <pre>list(object({<br>    sourceVolume = string<br>    containerPath = string<br>    readOnly : bool<br>  }))</pre> | n/a | yes |
| name | Name of the container | `string` | n/a | yes |
| portMappings | Container definition port mapping | <pre>list(object({<br>    hostPort = number<br>    protocol = string<br>    containerPort = number<br>  }))</pre> | n/a | yes |
| privileged | When this parameter is true, the container is given elevated privileges on the host container instance | `bool` | n/a | yes |
| pseudoTerminal | When this parameter is true, a TTY is allocated | `bool` | n/a | yes |
| readonlyRootFilesystem | When this parameter is true, the container is given read-only access to its root file system | `bool` | n/a | yes |
| resourceRequirements | Task definistion resource requirements | `list(string)` | n/a | yes |
| secrets | The secret to expose to your container | <pre>list(object({<br>    name = string<br>    valueFrom = string<br>  }))</pre> | n/a | yes |
| startTimeout | Container definition start timeout | `number` | n/a | yes |
| stopTimeout | Task defintion stop timeout | `number` | n/a | yes |
| systemControls | A list of namespaced kernel parameters to set in the container | <pre>list(object({<br>    namespace = string<br>    value = string<br>  }))</pre> | n/a | yes |
| ulimits | Container definition unit limits | <pre>list(object({<br>    name = string<br>    softLimit = number<br>    hardLimit = number<br>  }))</pre> | n/a | yes |
| user | Container definition user | `string` | n/a | yes |
| volumesFrom | Data volumes to mount from another container | <pre>list(object({<br>    sourceContainer = string<br>    readOnly = bool<br>  }))</pre> | n/a | yes |
| workingDirectory | The working directory in which to run commands inside the container | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| container\_definition | json encoded container definition |