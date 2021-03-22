## Purpose
1. The implementation of ecs task definition

## Usage example
```
module "task_definition" {
  source  = "../../modules/containers/ecs/task_definition"
  enabled = true

  inference_accelerator    = []
  proxy_configuration      = []
  placement_constraints    = []
  docker_volumes           = {}
  efs_volumes              = {}
  container_definitions    = format("[%s]", container_definition)
  task_role_arn            = role_arn
  execution_role_arn       = exec_role_arn
  network_mode             = "awsvpc"
  ipc_mode                 = null
  pid_mode                 = null
  cpu                      = 1024
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]

  #Naming
  naming_oe                    = "orgname"
  naming_project_name          = "projectname"
  naming_environment_name      = "prod"
  naming_ext                   = "jenkins"
  naming_delimiter             = "_"
  naming_additional_attributes = ""
  naming_additional_tags       = []
}
```
   
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| container\_definitions | A list of valid container definitions provided as a single valid JSON document. Please note that you should only provide values that are part of the container definition document. | `string` | n/a | yes |
| cpu | The number of cpu units used by the task. If the requires\_compatibilities is FARGATE this field is required | `number` | n/a | yes |
| docker\_volumes | A set of docker volume blocks that containers in your task may use | <pre>map(object({<br>    scope         = string<br>    autoprovision = bool<br>    driver        = string<br>    driver_opts   = map(string)<br>    labels        = map(string)<br>  }))</pre> | n/a | yes |
| efs\_volumes | A set of efs volume blocks that containers in your task may use | <pre>map(object({<br>    type           = string<br>    file_system_id = string<br>    root_directory = string<br>  }))</pre> | n/a | yes |
| enabled | Create a new ecs task definition | `bool` | n/a | yes |
| execution\_role\_arn | The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume | `string` | n/a | yes |
| inference\_accelerator | Definition of interface accelerator - type is list because of usage of dynamic | <pre>list(object({<br>    device_name = string<br>    device_type = string<br>  }))</pre> | n/a | yes |
| ipc\_mode | The IPC resource namespace to be used for the containers in the task The valid values are host, task, and none | `string` | n/a | yes |
| memory | The amount (in MiB) of memory used by the task. If the requires\_compatibilities is FARGATE this field is required | `number` | n/a | yes |
| naming\_additional\_attributes | Additional attributes (e.g. `policy` or `role`) | `list` | n/a | yes |
| naming\_additional\_tags | Additional tags (e.g. `map('BusinessUnit`,`XYZ`) | `map` | n/a | yes |
| naming\_delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | n/a | yes |
| naming\_environment\_name | Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared' | `string` | n/a | yes |
| naming\_ext | extension to the full name, e.g. Sequence or additional name | `string` | n/a | yes |
| naming\_oe | Organisational entity name | `string` | n/a | yes |
| naming\_project\_name | Project name if projects has it's own environment | `string` | n/a | yes |
| network\_mode | The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host | `string` | n/a | yes |
| pid\_mode | The process namespace to use for the containers in the task. The valid values are host and task | `string` | n/a | yes |
| placement\_constraints | A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement\_constraints is 10 | <pre>list(object({<br>    type       = string<br>    expression = string<br>  }))</pre> | n/a | yes |
| proxy\_configuration | Definition of proxy configuration - type is list because of usage of dynamic | <pre>list(object({<br>    container_name = string<br>    properties     = map(string)<br>    type           = string<br>  }))</pre> | n/a | yes |
| requires\_compatibilities | A set of launch types required by the task. The valid values are EC2 and FARGATE | `list(string)` | n/a | yes |
| task\_role\_arn | The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | Full ARN of the Task Definition (including both family and revision) |
| family | The family of the Task Definition |
| revision | The revision of the task in a particular family |