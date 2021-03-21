## Purpose

1. The generation of Subnet group
2. The generation of associate route tables

## Usage example

```
module "public_subnet" {
  source   = "../../modules/network/subnet"
  vpc_id   = vpc_id
  region   = "eu-central-1"
  subnet   = subnet_map
  igw_id   = igw_id
  natgw_id = ""

  #Naming
  naming_oe                    = "orgname"
  naming_project_name          = "projectname"
  naming_environment_name      = "prod"
  naming_delimiter             = "_"
  naming_additional_attributes = []
  naming_additional_tags       = []
}
```

## Usage example of subnet map

```
public_subnet = {
  cidrs                   = ["10.0.0.0/21", "10.0.8.0/21"]
  subnet_type             = "public"
  map_public_ip_on_launch = true
  natgw_destination_cidr  = ""
  igw_destination_cidr    = "0.0.0.0/0"
}
```

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| igw\_id | Internet gateway id | `string` | n/a | yes |
| naming\_additional\_attributes | Additional attributes (e.g. `policy` or `role`) | `list` | n/a | yes |
| naming\_additional\_tags | Additional tags (e.g. `map('BusinessUnit`,`XYZ`) | `map` | n/a | yes |
| naming\_delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | n/a | yes |
| naming\_environment\_name | Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared' | `string` | n/a | yes |
| naming\_oe | Organisational entity name | `string` | n/a | yes |
| naming\_project\_name | Project name if projects has it's own environment | `string` | n/a | yes |
| natgw\_id | NAT Gateway ID | `string` | n/a | yes |
| region | Name of AWS region | `string` | n/a | yes |
| subnet | Map of subnet properties | <pre>object({<br>    cidrs                   = list(string)<br>    subnet_type             = string<br>    map_public_ip_on_launch = bool<br>    natgw_destination_cidr  = string<br>    igw_destination_cidr    = string<br>  })</pre> | n/a | yes |
| vpc\_id | The VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| subnet\_id | The ID of the subnet |