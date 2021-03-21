## Purpose

1. The generation of VPC
2. The generation of Internet gateway

## Usage example

```
module "vpc" {
  source                         = "../../modules/network/vpc"
  cidr                           = "10.100.0.0/21"
  instance_tenancy               = "default"
  enable_dns_hostnames           = true
  enable_dns_support             = true
  enable_classiclink             = false
  enable_ipv6                    = false
  enable_classiclink_dns_support = false
  create_igw                     = true

  #Naming
  naming_oe                    = "orgname"
  naming_project_name          = "projectname"
  naming_environment_name      = "prod"
  naming_ext                   = "example"
  naming_delimiter             = "_"
  naming_additional_attributes = []
  naming_additional_tags       = []
```

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cidr | The CIDR block for the VPC. Default value is a valid CIDR | `string` | n/a | yes |
| create\_igw | Create IGW and attach it to VPC | `bool` | n/a | yes |
| enable\_classiclink | Should be true to enable ClassicLink for the VPC | `bool` | n/a | yes |
| enable\_classiclink\_dns\_support | Should be true to enable ClassicLink DNS Support for the VPC | `bool` | n/a | yes |
| enable\_dns\_hostnames | Should be true to enable DNS hostnames in the VPC | `bool` | n/a | yes |
| enable\_dns\_support | Should be true to enable DNS support in the VPC | `bool` | n/a | yes |
| enable\_ipv6 | Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC | `bool` | n/a | yes |
| instance\_tenancy | A tenancy option for instances launched into the VPC | `string` | n/a | yes |
| naming\_additional\_attributes | Additional attributes (e.g. `policy` or `role`) | `list` | n/a | yes |
| naming\_additional\_tags | Additional tags (e.g. `map('BusinessUnit`,`XYZ`) | `map` | n/a | yes |
| naming\_delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | n/a | yes |
| naming\_environment\_name | Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared' | `string` | n/a | yes |
| naming\_ext | extension to the full name, e.g. Sequence or additional name | `string` | n/a | yes |
| naming\_oe | Organisational entity name | `string` | n/a | yes |
| naming\_project\_name | Project name if projects has it's own environment | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| igw\_id | Internet gateway ID attached to VPC |
| vpc\_cidr\_block | The CIDR block of the VPC |
| vpc\_id | The ID of the VPC |