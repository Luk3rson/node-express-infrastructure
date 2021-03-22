/*=====================================
## Security group module
## ==================================*/

variable "vpcid" {
  description = "ID of the VPC"
  type        = string
}

variable "sgdescription" {
  type        = string
  description = "Describe the purpose of security group"
}

variable "sg_in_cidr_rules" {
  type        = list
  description = "List of ingress rules where source is cidr"
}

variable "sg_eg_cidr_rules" {
  type        = list
  description = "List of egress rules where source is cidr"

}

variable "sg_in_sgsrc_rules" {
  type        = list
  description = "List of ingress rules where source is security group"
}

variable "sg_eg_sgsrc_rules" {
  type        = list
  description = "List of ingress rules where source is security group"
}

variable "sg_insrc_count" {
  default = 0
}
