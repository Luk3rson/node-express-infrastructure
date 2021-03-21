################################################################################################
# ECR repository variables
################################################################################################
variable "enabled" {
  type        = bool
  description = "Create a repo"
}

variable "image_tag_mutability" {
  type        = string
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE"
}

variable "image_scanning_configuration" {
  type = list(object({
    scan_on_push = bool
  }))
  description = "Configuration block that defines image scanning configuration for the repository."
}

################################################################################################
# ECR repository policy variables
################################################################################################

variable "repo_policy" {
  type        = string
  description = "The policy document. This is a JSON formatted string. "
}

variable "repo_lifecycle_policy" {
  type        = string
  description = "The policy document. This is a JSON formatted string. "
}