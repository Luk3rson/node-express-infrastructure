################################################################################################
# CodeBuild resource
################################################################################################
module "codebuild_naming" {
  source      = "../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_codebuild_role_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_codebuild_project" "codebuild" {
  count = var.enabled ? 1 : 0

  name           = module.codebuild_naming.id
  badge_enabled  = var.badge_enabled
  build_timeout  = var.build_timeout
  queued_timeout = var.queued_timeout
  description    = var.description
  encryption_key = var.encryption_key
  service_role   = var.service_role
  source_version = var.source_version
  tags           = module.codebuild_naming.tags

  dynamic "artifacts" {
    for_each = length(var.artifacts) > 0 ? var.artifacts : []
    content {
      type                   = artifacts.value.type
      artifact_identifier    = artifacts.value.artifact_identifier
      encryption_disabled    = artifacts.value.encryption_disabled
      override_artifact_name = artifacts.value.override_artifact_name
      location               = artifacts.value.location
      name                   = artifacts.value.name
      namespace_type         = artifacts.value.namespace_type
      packaging              = artifacts.value.packaging
      path                   = artifacts.value.path
    }
  }

  dynamic "environment" {
    for_each = length(var.environment) > 0 ? var.environment : []
    content {
      compute_type                = environment.value.compute_type
      image                       = environment.value.image
      type                        = environment.value.type
      image_pull_credentials_type = environment.value.image_pull_credentials_type
      privileged_mode             = environment.value.privileged_mode
      certificate                 = environment.value.certificate

      dynamic "registry_credential" {
        for_each = length(environment.value.registry_credential) > 0 ? environment.value.registry_credential : []
        content {
          credential          = registry_credential.value.credential
          credential_provider = registry_credential.value.credential_provider
        }
      }

      dynamic "environment_variable" {
        for_each = length(environment.value.environment_variable) > 0 ? environment.value.environment_variable : []
        content {
          name  = environment_variable.value.name
          value = environment_variable.value.value
          type  = environment_variable.value.type
        }
      }
    }
  }

  dynamic "source" {
    for_each = length(var.cb_source) > 0 ? var.cb_source : []
    content {
      type                = source.value.type
      buildspec           = source.value.buildspec
      git_clone_depth     = source.value.git_clone_depth
      insecure_ssl        = source.value.insecure_ssl
      location            = source.value.location
      report_build_status = source.value.report_build_status
      dynamic "git_submodules_config" {
        for_each = length(source.value.git_submodules_config) > 0 ? source.value.git_submodules_config : []
        content {
          fetch_submodules = git_submodules_config.value.fetch_submodules
        }
      }

      dynamic "auth" {
        for_each = length(source.value.auth) > 0 ? source.value.auth : []
        content {
          type     = auth.value.type
          resource = auth.value.resource
        }
      }
    }
  }

  dynamic "cache" {
    for_each = length(var.cache) > 0 ? var.cache : []
    content {
      type     = cache.value.type
      location = cache.value.location
      modes    = cache.value.modes
    }
  }

  dynamic "logs_config" {
    for_each = length(var.logs_config) > 0 ? var.logs_config : []
    content {
      dynamic "cloudwatch_logs" {
        for_each = length(logs_config.value.cloudwatch_logs) > 0 ? logs_config.value.cloudwatch_logs : []
        content {
          status      = cloudwatch_logs.value.status
          group_name  = cloudwatch_logs.value.group_name
          stream_name = cloudwatch_logs.value.stream_name
        }
      }
      dynamic "s3_logs" {
        for_each = length(logs_config.value.s3_logs) > 0 ? logs_config.value.s3_logs : []
        content {
          status              = s3_logs.value.status
          location            = s3_logs.value.location
          encryption_disabled = s3_logs.value.encryption_disabled
        }
      }
    }
  }

  dynamic "vpc_config" {
    for_each = length(var.vpc_config) > 0 ? var.vpc_config : []
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnets            = vpc_config.value.subnets
      vpc_id             = vpc_config.value.vpc_id
    }
  }

  dynamic "secondary_artifacts" {
    for_each = length(var.secondary_artifacts) > 0 ? var.secondary_artifacts : []
    content {
      type                   = secondary_artifacts.value.type
      artifact_identifier    = secondary_artifacts.value.artifact_identifier
      encryption_disabled    = secondary_artifacts.value.encryption_disabled
      override_artifact_name = secondary_artifacts.value.override_artifact_name
      location               = secondary_artifacts.value.location
      name                   = secondary_artifacts.value.name
      namespace_type         = secondary_artifacts.value.namespace_type
      packaging              = secondary_artifacts.value.packaging
      path                   = secondary_artifacts.value.path
    }
  }


  dynamic "secondary_sources" {
    for_each = length(var.secondary_sources) > 0 ? var.secondary_sources : []
    content {
      type                = secondary_sources.value.type
      buildspec           = secondary_sources.value.buildspec
      source_identifier   = secondary_sources.value.source_identifier
      git_clone_depth     = secondary_sources.value.git_clone_depth
      insecure_ssl        = secondary_sources.value.insecure_ssl
      location            = secondary_sources.value.location
      report_build_status = secondary_sources.value.report_build_status

      dynamic "git_submodules_config" {
        for_each = length(secondary_sources.value.git_submodules_config) > 0 ? secondary_sources.value.git_submodules_config : []
        content {
          fetch_submodules = git_submodules_config.value.fetch_submodules
        }
      }

      dynamic "auth" {
        for_each = length(secondary_sources.value.auth) > 0 ? secondary_sources.value.auth : []
        content {
          type     = auth.value.type
          resource = auth.value.resource
        }
      }
    }
  }
}

################################################################################################
# CodeBuild source credentials
################################################################################################
resource "aws_codebuild_source_credential" "cb_creds" {
  count       = var.cbs_auth_type != "" && var.cbs_server_type != "" && var.cbs_token != "" ? 1 : 0
  auth_type   = var.cbs_auth_type
  server_type = var.cbs_server_type
  token       = var.cbs_token
  user_name   = var.cbs_user_name
}

################################################################################################
# CodeBuild web hook
################################################################################################
resource "aws_codebuild_webhook" "cb_webhook" {
  count        = var.enabled && length(var.cb_webhook_filter_group) > 0 ? 1 : 0
  project_name = aws_codebuild_project.codebuild[count.index].name

  dynamic "filter_group" {
    for_each = length(var.cb_webhook_filter_group) > 0 ? var.cb_webhook_filter_group : []
    content {
      dynamic "filter" {
        for_each = length(filter_group.value.filter) > 0 ? filter_group.value.filter : []
        content {
          type                    = filter.value.type
          pattern                 = filter.value.pattern
          exclude_matched_pattern = filter.value.exclude_matched_pattern
        }
      }
    }
  }
}