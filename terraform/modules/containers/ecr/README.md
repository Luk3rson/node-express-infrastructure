## Purpose
1. The implementation of ecr repository
2. The implementation of ecr repo policy
3. The implementation of ecr repo life cycle policy

## Usage example
```
module "application_ecr" {
  source = "../../modules/containers/ecr"

  enabled                      = true
  image_tag_mutability         = true
  image_scanning_configuration = false
  repo_policy                  = ""
  repo_lifecycle_policy        = ""

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
| enabled | Create a repo | `bool` | n/a | yes |
| image\_scanning\_configuration | Configuration block that defines image scanning configuration for the repository. | <pre>list(object({<br>    scan_on_push = bool<br>  }))</pre> | n/a | yes |
| image\_tag\_mutability | The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE | `string` | n/a | yes |
| naming\_additional\_attributes | Additional attributes (e.g. `policy` or `role`) | `list` | n/a | yes |
| naming\_additional\_tags | Additional tags (e.g. `map('BusinessUnit`,`XYZ`) | `map` | n/a | yes |
| naming\_delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | n/a | yes |
| naming\_environment\_name | Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared' | `string` | n/a | yes |
| naming\_ext | extension to the full name, e.g. Sequence or additional name | `string` | n/a | yes |
| naming\_oe | Organisational entity name | `string` | n/a | yes |
| naming\_project\_name | Project name if projects has it's own environment | `string` | n/a | yes |
| repo\_lifecycle\_policy | The policy document. This is a JSON formatted string. | `string` | n/a | yes |
| repo\_policy | The policy document. This is a JSON formatted string. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | Full ARN of the repository |
| name | The name of the repository |
| registry\_id | The registry ID where the repository was created |
| repository\_url | The URL of the repository (in the form aws\_account\_id.dkr.ecr.region.amazonaws.com/repositoryName) |