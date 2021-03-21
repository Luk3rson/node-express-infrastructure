## Purpose

1. The generation of IAM role
2. The generation of IAM policy
3. Attachement of policies to role

## Usage example

```
module "example_role" {
  source                             = "../../modules/iam/assumable_role"
  assume_role_iam_policy_identifiers = ["lambda.amazonaws.com"]
  iam_policy_arns                    = ["arn:aws:iam::aws:policy/service-role/LambdaPushToCloudWatchLogs"]
  role_policy                        = data.template_file.example_role_policy.rendered
  force_detach_policies              = false
  description                        = "Example IAM role"
  max_session_duration               = 3600
  policy_description                 = "Example IAM role polcy"
  number_of_attached_policies        = 2

  #Naming
  naming_oe                           = "orgname"
  naming_project_name                 = "projectname"
  naming_environment_name             = "prod"
  naming_ext                          = "example"
  naming_delimiter                    = "_"
  naming_additional_attributes        = "sshkey"
  naming_additional_tags              = []
  naming_policy_additional_attributes = []
}
```

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| assume\_role\_iam\_policy\_identifiers | List of identifiers for assume role | `list` | n/a | yes |
| description | The description of the role | `string` | n/a | yes |
| force\_detach\_policies | Specifies to force detaching any policies the role has before destroying it | `bool` | n/a | yes |
| iam\_policy\_arns | IAM policy arns for attachement to policy | `list(string)` | n/a | yes |
| max\_session\_duration | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. | `number` | n/a | yes |
| naming\_additional\_attributes | Additional attributes (e.g. `policy` or `role`) | `list` | n/a | yes |
| naming\_additional\_tags | Additional tags (e.g. `map('BusinessUnit`,`XYZ`) | `map` | n/a | yes |
| naming\_delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | n/a | yes |
| naming\_environment\_name | Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared' | `string` | n/a | yes |
| naming\_ext | extension to the full name, e.g. Sequence or additional name | `string` | n/a | yes |
| naming\_oe | Organisational entity name | `string` | n/a | yes |
| naming\_policy\_additional\_attributes | Additional attributes (e.g. `policy` or `role`) | `list` | n/a | yes |
| naming\_project\_name | Project name if projects has it's own environment | `string` | n/a | yes |
| number\_of\_attached\_policies | The number of attached policies. This is due terraform funcionality. Terraform cannot be determined until apply | `number` | n/a | yes |
| policy\_description | The description of role policy | `string` | n/a | yes |
| role\_policy | The policy document. This is a JSON formatted string. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| role\_arn | n/a |
| role\_name | n/a |