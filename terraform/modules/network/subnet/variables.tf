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

variable "natgw_id" {
  type        = string
  description = "NAT Gateway ID"
}
