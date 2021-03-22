variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "region" {
  type        = string
  description = "Name of AWS region"
}

variable "subnet" {
  type = object({
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
  description = "Map of subnet properties"
}

variable "azs" {
  type        = list(string)
  description = "A list of availability zone extensions. Example a,b"
}

variable "igw_id" {
  type        = string
  description = "Internet gateway id"
}

variable "natgw_ids" {
  type        = list(string)
  description = "NAT Gateway IDs"
}