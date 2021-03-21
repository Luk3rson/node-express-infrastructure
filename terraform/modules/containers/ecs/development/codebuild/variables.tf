################################################################################################
# CodeBuild variables
################################################################################################
variable "enabled" {
  type        = bool
  description = "Create a new codebuild project"
}

variable "badge_enabled" {
  type        = bool
  description = "Generates a publicly-accessible URL for the projects build badge. Available as badge_url attribute when enabled"
}

variable "build_timeout" {
  type        = number
  description = "How long in minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed."
}

variable "queued_timeout" {
  type        = number
  description = "How long in minutes, from 5 to 480 (8 hours), a build is allowed to be queued before it times out"
}

variable "description" {
  type        = string
  description = "A short description of the project"
}

variable "encryption_key" {
  type        = string
  description = "The AWS Key Management Service (AWS KMS) customer master key (CMK) to be used for encrypting the build project's build output artifacts"
}

variable "service_role" {
  type        = string
  description = "The Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) role that enables AWS CodeBuild to interact with dependent AWS services on behalf of the AWS account"
}

variable "source_version" {
  type        = string
  description = "A version of the build input to be built for this project. If not specified, the latest version is used"
}

variable "artifacts" {
  type = list(object({
    type                   = string
    artifact_identifier    = string
    encryption_disabled    = bool
    override_artifact_name = bool
    location               = string
    name                   = string
    namespace_type         = string
    packaging              = string
    path                   = string
  }))
  description = "Information about the project's build output artifacts"
}

variable "environment" {
  type = list(object({
    compute_type                = string
    image                       = string
    type                        = string
    image_pull_credentials_type = string
    privileged_mode             = bool
    certificate                 = string
    registry_credential = list(object({
      credential          = string
      credential_provider = string
    }))
    environment_variable = list(any)
  }))
  description = "Information about the project's build environment"
}

variable "cb_source" {
  type = list(object({
    type                = string
    buildspec           = string
    git_clone_depth     = number
    insecure_ssl        = bool
    location            = string
    report_build_status = bool
    git_submodules_config = list(object({
      fetch_submodules = bool
    }))
    auth = list(object({
      type     = string
      resource = string
    }))
  }))
  description = "Information about the project's input source code"
}

variable "cache" {
  type = list(object({
    type     = string
    location = string
    modes    = list(string)
  }))
  description = "Information about the cache storage for the project"
}

variable "logs_config" {
  type = list(object({
    cloudwatch_logs = list(object({
      status      = string
      group_name  = string
      stream_name = string
    }))
    s3_logs = list(object({
      status              = string
      location            = string
      encryption_disabled = bool
    }))
  }))
  description = "Configuration for the builds to store log data to CloudWatch or S3"
}

variable "vpc_config" {
  type = list(object({
    security_group_ids = list(string)
    subnets            = list(string)
    vpc_id             = string
  }))
  description = "Configuration for the builds to run inside a VPC. VPC config blocks are documented below"
}

variable "secondary_artifacts" {
  type = list(object({
    type                   = string
    artifact_identifier    = string
    encryption_disabled    = bool
    override_artifact_name = bool
    location               = string
    name                   = string
    namespace_type         = string
    packaging              = string
    path                   = string
  }))
  description = "A set of secondary artifacts to be used inside the build. Secondary artifacts blocks are documented below"
}

variable "secondary_sources" {
  type = list(object({
    type                = string
    buildspec           = string
    source_identifier   = string
    git_clone_depth     = number
    insecure_ssl        = bool
    location            = string
    report_build_status = bool
    git_submodules_config = list(object({
      fetch_submodules = bool
    }))
    auth = list(object({
      type     = string
      resource = string
    }))
  }))
  description = "A set of secondary sources to be used inside the build. Secondary sources blocks are documented below"
}

################################################################################################
# CodeBuild source credentials variables
################################################################################################
variable "cbs_auth_type" {
  type        = string
  description = "The type of authentication used to connect to a GitHub, GitHub Enterprise, or Bitbucket repository. An OAUTH connection is not supported by the API"
}

variable "cbs_server_type" {
  type        = string
  description = "The source provider used for this project"
}

variable "cbs_token" {
  type        = string
  description = "For GitHub or GitHub Enterprise, this is the personal access token. For Bitbucket, this is the app password"
}

variable "cbs_user_name" {
  type        = string
  description = "The Bitbucket username when the authType is BASIC_AUTH. This parameter is not valid for other types of source providers or connections"
}

################################################################################################
# CodeBuild Webhook variables
################################################################################################
variable "cb_webhook_filter_group" {
  type = list(object({
    filter = list(object({
      type                    = string
      pattern                 = string
      exclude_matched_pattern = bool
    }))
  }))
  description = "Information about the webhook's trigger"
}

