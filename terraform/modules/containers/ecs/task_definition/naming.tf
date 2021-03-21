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

variable "naming_ext" {
  description = "extension to the full name, e.g. Sequence or additional name"
  type        = string
}

variable "naming_delimiter" {
  type        = string
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "naming_additional_attributes" {
  type        = list
  description = "Additional attributes (e.g. `policy` or `role`)"
}

variable "naming_additional_tags" {
  type        = map
  description = "Additional tags (e.g. `map('BusinessUnit`,`XYZ`)"
}
