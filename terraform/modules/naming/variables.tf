variable "oe" {
  type        = string
  description = "Organisational entity name"
}

variable "project" {
  type        = string
  description = "Project name if projects has it's own environment"
}

variable "environment" {
  type        = string
  description = "Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared'"
}

variable "role" {
  type        = string
  description = "Role or Scope of the Service, e.g. 'ldap' or application name like 'jenkins'"
}

variable "ext" {
  description = "extension to the full name, e.g. Sequence or additional name"
  type        = string
}

variable "delimiter" {
  type        = string
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "attributes" {
  type        = list
  description = "Additional attributes (e.g. `policy` or `role`)"
}

variable "tags" {
  type        = map
  description = "Additional tags (e.g. `map('BusinessUnit`,`XYZ`)"
}
