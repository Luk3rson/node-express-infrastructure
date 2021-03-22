######################################################
# VPC variables
######################################################
variable "region" {
  type        = string
  description = "The name of AWS region"
}

######################################################
# VPC variables
######################################################
variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR"
  type        = string
}

variable "create_igw" {
  type        = bool
  description = "Create IGW and attach it to VPC"
}

######################################################
# Subnet variables
######################################################
variable "subnets" {
  type = map(object({
    cidrs                   = list(string)
    subnet_type             = string
    map_public_ip_on_launch = bool
    natgw_destination_cidr  = string
    igw_destination_cidr    = string
    nacl_rules = map(object({
      from_port  = number,
      to_port    = number,
      rule_no    = number,
      action     = string,
      protocol   = string,
      cidr_block = string,
      egress     = bool
    }))
  })
  )
}

variable "azs" {
  type        = list(string)
  description = "A list of availability zone extensions. Example a,b"
}

######################################################
# Naming variables
######################################################
variable "naming_oe" {
  type        = string
  description = "Organisational entity name"
}

variable "naming_project_name" {
  type        = string
  description = "Project name if projects has it's own environment"
}

variable "naming_environment_name" {
  type        = string
  description = "Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared'"
}
