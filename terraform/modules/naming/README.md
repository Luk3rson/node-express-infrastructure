## Purpose

1. The generation of standard resource name
2. The generation of standard resource tags

## Usage example

```
module "step_function_naming" {
  source      = "../../naming"
  oe          = "orgname"
  project     = "projectname"
  environment = "prod"
  role        = "stepfunction"
  ext         = ""
  delimiter   = "-"
  attributes  = []
  tags        = []
}
```

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| attributes | Additional attributes (e.g. `policy` or `role`) | `list` | n/a | yes |
| delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | n/a | yes |
| environment | Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared' | `string` | n/a | yes |
| ext | extension to the full name, e.g. Sequence or additional name | `string` | n/a | yes |
| oe | Organisational entity name | `string` | n/a | yes |
| project | Project name if projects has it's own environment | `string` | n/a | yes |
| role | Role or Scope of the Service, e.g. 'ldap' or application name like 'jenkins' | `string` | n/a | yes |
| tags | Additional tags (e.g. `map('BusinessUnit`,`XYZ`) | `map` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cf\_friendly\_asg\_tag\_list | n/a |
| cf\_friendly\_tags | Normalized Tag map |
| id | Disambiguated ID |
| tag\_list | TODO: Add additional Tags to List |
| tags | Normalized Tag map |