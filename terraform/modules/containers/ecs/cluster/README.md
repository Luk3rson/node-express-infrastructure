## Purpose
1. The implementation of ecs cluster

## Usage example
```
module "cluster" {
  source = "../../modules/containers/ecs/cluster"

  enabled                            = true
  capacity_providers                 = ["FARGATE", "FARGATE_SPOT"]
  default_capacity_provider_strategy = []
  ecs_application_cluster_settings = [
    {
      name  = "containerInsights"
      value = "disabled"
    }
  ]

  #Naming
  naming_oe                    = "orgname"
  naming_project_name          = "projectname"
  naming_environment_name      = "prod"
  naming_ext                   = "lupho"
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
| capacity\_providers | List of short names of one or more capacity providers to associate with the cluster. Valid values also include FARGATE and FARGATE\_SPOT | `list(string)` | n/a | yes |
| default\_capacity\_provider\_strategy | The capacity provider strategy to use by default for the cluster. Can be one or more. | <pre>list(object({<br>    capacity_provider_short_name = string<br>    weight                       = number<br>    base                         = number<br>  }))</pre> | n/a | yes |
| enabled | Create a new ecs cluster | `bool` | n/a | yes |
| naming\_additional\_attributes | Additional attributes (e.g. `policy` or `role`) | `list` | n/a | yes |
| naming\_additional\_tags | Additional tags (e.g. `map('BusinessUnit`,`XYZ`) | `map` | n/a | yes |
| naming\_delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | n/a | yes |
| naming\_environment\_name | Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared' | `string` | n/a | yes |
| naming\_ext | extension to the full name, e.g. Sequence or additional name | `string` | n/a | yes |
| naming\_oe | Organisational entity name | `string` | n/a | yes |
| naming\_project\_name | Project name if projects has it's own environment | `string` | n/a | yes |
| settings | The capacity provider strategy to use by default for the cluster. Can be one or more. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | The Amazon Resource Name (ARN) that identifies the cluster |
| id | The Amazon Resource Name (ARN) that identifies the cluster |