## Purpose

1. The generation of Elastic IP
2. The generation of NAT Gateway
3. Attachement of EIP to NGW

## Usage example

```
module "natgw" {
  source     = "../../modules/network/natgw"
  nat_subnet = public_subnet_id
  eip_vpc    = vpcid

  #Naming
  naming_oe                    = "orgname"
  naming_project_name          = "projectname"
  naming_environment_name      = "prod"
  naming_ext                   = "example"
  naming_delimiter             = "_"
  naming_additional_attributes = []
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
| eip\_vpc | Boolean if the EIP is in a VPC or not | `bool` | n/a | yes |
| naming\_additional\_attributes | Additional attributes (e.g. `policy` or `role`) | `list` | n/a | yes |
| naming\_additional\_tags | Additional tags (e.g. `map('BusinessUnit`,`XYZ`) | `map` | n/a | yes |
| naming\_delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | n/a | yes |
| naming\_environment\_name | Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared' | `string` | n/a | yes |
| naming\_ext | extension to the full name, e.g. Sequence or additional name | `string` | n/a | yes |
| naming\_oe | Organisational entity name | `string` | n/a | yes |
| naming\_project\_name | Project name if projects has it's own environment | `string` | n/a | yes |
| nat\_subnet | Subnet where NAT gateway will be deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| natgw\_id | The ID of the NAT Gateway |
| naygw\_eip | Elastic IP attached to NATGW |