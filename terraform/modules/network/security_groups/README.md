## Purpose

1. The generation of Security group
2. Attachement of inboud rules where source is cidr
3. Attachement of inbound rules where source is security group
4. Attachement of outbound rules where source is cidr
5. Attachement of outbound rules where source is security group

## Usage example

```
module "example_sg" {
  source            = "../../modules/network/security_groups"
  vpcid             = var.vpcid
  sgdescription     = "Example security group"
  sg_in_cidr_rules  = list_of_inbound_cidr_rules
  sg_eg_cidr_rules  = list_of_outbund_cidr_rules
  sg_in_sgsrc_rules = list_of_inbound_sg_rules
  sg_eg_sgsrc_rules = list_of_outbound_sg_rules
  sg_insrc_count    = 2

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

## Usage example of list rules

```
  // Ingress rules from CIDR
  ingress_cidr = [
    {
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      from_port   = "0"
      to_port     = "65535"
      description = "All TCP inbound"
    },
    {
      protocol    = "udp"
      cidr_blocks = "0.0.0.0/0"
      from_port   = "0"
      to_port     = "65535"
      description = "All UDP inbound"
    },
  ]
  // Egress rules from CIDR
  egress_cidr = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  // Ingress rules for security group source
  ingress_sg = [
    {
      protocol    = "tcp"
      src_sg_id   = module.example_sg.sg_id
      from_port   = 8080
      to_port     = 8080
      description = "Example service"
    },
    {
      protocol    = "tcp"
      src_sg_id   = module.example_sg.sg_id
      from_port   = "22"
      to_port     = "22"
      description = "SSH access"
    },
  ]
}
```
   
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| naming\_additional\_attributes | Additional attributes (e.g. `policy` or `role`) | `list` | n/a | yes |
| naming\_additional\_tags | Additional tags (e.g. `map('BusinessUnit`,`XYZ`) | `map` | n/a | yes |
| naming\_delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | n/a | yes |
| naming\_environment\_name | Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared' | `string` | n/a | yes |
| naming\_ext | extension to the full name, e.g. Sequence or additional name | `string` | n/a | yes |
| naming\_oe | Organisational entity name | `string` | n/a | yes |
| naming\_project\_name | Project name if projects has it's own environment | `string` | n/a | yes |
| sg\_eg\_cidr\_rules | List of egress rules where source is cidr | `list` | n/a | yes |
| sg\_eg\_sgsrc\_rules | List of ingress rules where source is security group | `list` | n/a | yes |
| sg\_in\_cidr\_rules | List of ingress rules where source is cidr | `list` | n/a | yes |
| sg\_in\_sgsrc\_rules | List of ingress rules where source is security group | `list` | n/a | yes |
| sg\_insrc\_count | n/a | `number` | `0` | no |
| sgdescription | Describe the purpose of security group | `string` | n/a | yes |
| vpcid | ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| sg\_id | Security geoup ID |