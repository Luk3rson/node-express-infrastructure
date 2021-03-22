variable "assume_role_iam_policy_identifiers" {
  type        = list
  description = "List of identifiers for assume role"
}

variable "iam_policy_arns" {
  type        = list(string)
  description = "IAM policy arns for attachement to policy"
}

variable "role_policy_count" {
  description = "The policy document. This is a JSON formatted string."
}

variable "role_policy" {
  type        = string
  description = "The policy document. This is a JSON formatted string."
}

variable "force_detach_policies" {
  type        = bool
  description = "Specifies to force detaching any policies the role has before destroying it"
}

variable "description" {
  type        = string
  description = "The description of the role"
}

variable "max_session_duration" {
  type        = number
  description = "The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
}

variable "policy_description" {
  type        = string
  description = "The description of role policy"
}

variable "number_of_attached_policies" {
  type        = number
  description = "The number of attached policies. This is due terraform funcionality. Terraform cannot be determined until apply"
}
