variable "name" {
    type = string
    description = "The name of the parameter. If the name contains a path (e.g. any forward slashes (/)), it must be fully qualified with a leading forward slash (/). For additional requirements and constraints"
}
 
variable "type" {
    type = string
    description = "The type of the parameter. Valid types are String, StringList and SecureString."
}
 
variable "value" {
    type = string
    description = "The value of the parameter"
}
 
variable "description" {
    type = string
    description = "The description of the parameter"
}

variable "tier" {
    type = string
    description = "The tier of the parameter. If not specified, will default to Standard. Valid tiers are Standard and Advanced"
}

variable "key_id" {
    type = string
    description = "The KMS key id or arn for encrypting a SecureString"
}

variable "overwrite" {
    type = bool
    description = "Overwrite an existing parameter. If not specified, will default to false if the resource has not been created by terraform to avoid overwrite of existing resource and will default to true otherwise (terraform lifecycle rules should then be used to manage the update behavior)."
}
 
variable "allowed_pattern" {
    type = string
    description = "A regular expression used to validate the parameter value"
}

variable "data_type" {
    type = string
    description = "The data_type of the parameter. Valid values: text and aws:ec2:image for AMI format, see the Native parameter support for Amazon Machine Image IDs"
}

variable "tags" {
    type = map(string)
    description = "A map of tags to assign to the object"
}