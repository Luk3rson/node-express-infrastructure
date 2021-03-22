######################################################
# NAT gateway variables
######################################################
variable "eip_vpc" {
  type        = bool
  description = "Boolean if the EIP is in a VPC or not"
}

variable "nat_subnet" {
  type        = string
  description = "Subnet where NAT gateway will be deployed"
}

variable "nat_gtw_enabled" {
  type = bool
  description = "Determines weather to create NAT Gateway or not"
}