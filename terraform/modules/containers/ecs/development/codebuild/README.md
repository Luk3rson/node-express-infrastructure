## Purpose
1. The implementation of cocebuild project
2. The implementation of codebuild source credentials
3. The implementation of codebuild webhook

## Usage example
```
module "codebuild" {
  source = "../../modules/development/codebuild"

  enabled                 = true
  badge_enabled           = false
  build_timeout           = 10
  queued_timeout          = 20
  description             = "Build docker image and push it to ECR"
  encryption_key          = ""
  source_version          = ""
  service_role            = role_arn
  artifacts               = [{
    type                   = "NO_ARTIFACTS"
    artifact_identifier    = null
    encryption_disabled    = null
    override_artifact_name = null
    location               = null
    name                   = null
    namespace_type         = null
    packaging              = null
    path                   = null
  }]
  environment             = [
    {
      compute_type                = "BUILD_GENERAL1_SMALL"
      image                       = "aws/codebuild/standard:2.0"
      type                        = "LINUX_CONTAINER"
      image_pull_credentials_type = "CODEBUILD"
      privileged_mode             = true
      certificate                 = null
      registry_credential         = []
      environment_variable = [
        {
          name  = "ECR_REPO_ID"
          value = split("/", ecr_repo_url[0])[0]
          type  = "PLAINTEXT"
        },
        {
          name  = "ECR_REPO_NAME"
          value = ecr_repo_name
          type  = "PLAINTEXT"
        }
      ]
    }
  ]
  cb_source               = [
    {
      type                  = "S3"
      buildspec             = "buildspec.yaml"
      git_clone_depth       = 0
      insecure_ssl          = true
      location              = location/package.zip
      report_build_status   = false
      git_submodules_config = []
      auth                  = []
    }
  ]
  cache                   = []
  secondary_artifacts     = []
  secondary_sources       = []
  logs_config             = [
    {
      cloudwatch_logs = [{
        status      = "ENABLED"
        group_name  = log_group_name
        stream_name = ""
      }]
      s3_logs = []
    }
  ]
  vpc_config              = []
  cbs_auth_type           = ""
  cbs_server_type         = ""
  cbs_token               = ""
  cbs_user_name           = ""
  cb_webhook_filter_group = []

  #Naming
  naming_oe                    = "orgname"
  naming_project_name          = "projectname"
  naming_environment_name      = "prod"
  naming_ext                   = "jenkins"
  naming_delimiter             = "_"
  naming_additional_attributes = ""
  naming_additional_tags       = []
}
```


## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| artifacts | Information about the project's build output artifacts | <pre>list(object({<br>    type                   = string<br>    artifact_identifier    = string<br>    encryption_disabled    = bool<br>    override_artifact_name = bool<br>    location               = string<br>    name                   = string<br>    namespace_type         = string<br>    packaging              = string<br>    path                   = string<br>  }))</pre> | n/a | yes |
| badge\_enabled | Generates a publicly-accessible URL for the projects build badge. Available as badge\_url attribute when enabled | `bool` | n/a | yes |
| build\_timeout | How long in minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed. | `number` | n/a | yes |
| cache | Information about the cache storage for the project | <pre>list(object({<br>    type     = string<br>    location = string<br>    modes    = list(string)<br>  }))</pre> | n/a | yes |
| cb\_source | Information about the project's input source code | <pre>list(object({<br>    type                = string<br>    buildspec           = string<br>    git_clone_depth     = number<br>    insecure_ssl        = bool<br>    location            = string<br>    report_build_status = bool<br>    git_submodules_config = list(object({<br>      fetch_submodules = bool<br>    }))<br>    auth = list(object({<br>      type     = string<br>      resource = string<br>    }))<br>  }))</pre> | n/a | yes |
| cb\_webhook\_filter\_group | Information about the webhook's trigger | <pre>list(object({<br>    filter = list(object({<br>      type                    = string<br>      pattern                 = string<br>      exclude_matched_pattern = bool<br>    }))<br>  }))</pre> | n/a | yes |
| cbs\_auth\_type | The type of authentication used to connect to a GitHub, GitHub Enterprise, or Bitbucket repository. An OAUTH connection is not supported by the API | `string` | n/a | yes |
| cbs\_server\_type | The source provider used for this project | `string` | n/a | yes |
| cbs\_token | For GitHub or GitHub Enterprise, this is the personal access token. For Bitbucket, this is the app password | `string` | n/a | yes |
| cbs\_user\_name | The Bitbucket username when the authType is BASIC\_AUTH. This parameter is not valid for other types of source providers or connections | `string` | n/a | yes |
| description | A short description of the project | `string` | n/a | yes |
| enabled | Create a new codebuild project | `bool` | n/a | yes |
| encryption\_key | The AWS Key Management Service (AWS KMS) customer master key (CMK) to be used for encrypting the build project's build output artifacts | `string` | n/a | yes |
| environment | Information about the project's build environment | <pre>list(object({<br>    compute_type                = string<br>    image                       = string<br>    type                        = string<br>    image_pull_credentials_type = string<br>    privileged_mode             = bool<br>    certificate                 = string<br>    registry_credential = list(object({<br>      credential          = string<br>      credential_provider = string<br>    }))<br>    environment_variable = list(any)<br>  }))</pre> | n/a | yes |
| logs\_config | Configuration for the builds to store log data to CloudWatch or S3 | <pre>list(object({<br>    cloudwatch_logs = list(object({<br>      status      = string<br>      group_name  = string<br>      stream_name = string<br>    }))<br>    s3_logs = list(object({<br>      status              = string<br>      location            = string<br>      encryption_disabled = bool<br>    }))<br>  }))</pre> | n/a | yes |
| naming\_additional\_attributes | Additional attributes (e.g. `policy` or `role`) | `list` | n/a | yes |
| naming\_additional\_tags | Additional tags (e.g. `map('BusinessUnit`,`XYZ`) | `map` | n/a | yes |
| naming\_delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | n/a | yes |
| naming\_environment\_name | Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared' | `string` | n/a | yes |
| naming\_ext | extension to the full name, e.g. Sequence or additional name | `string` | n/a | yes |
| naming\_oe | Organisational entity name | `string` | n/a | yes |
| naming\_project\_name | Project name if projects has it's own environment | `string` | n/a | yes |
| queued\_timeout | How long in minutes, from 5 to 480 (8 hours), a build is allowed to be queued before it times out | `number` | n/a | yes |
| secondary\_artifacts | A set of secondary artifacts to be used inside the build. Secondary artifacts blocks are documented below | <pre>list(object({<br>    type                   = string<br>    artifact_identifier    = string<br>    encryption_disabled    = bool<br>    override_artifact_name = bool<br>    location               = string<br>    name                   = string<br>    namespace_type         = string<br>    packaging              = string<br>    path                   = string<br>  }))</pre> | n/a | yes |
| secondary\_sources | A set of secondary sources to be used inside the build. Secondary sources blocks are documented below | <pre>list(object({<br>    type                = string<br>    buildspec           = string<br>    source_identifier   = string<br>    git_clone_depth     = number<br>    insecure_ssl        = bool<br>    location            = string<br>    report_build_status = bool<br>    git_submodules_config = list(object({<br>      fetch_submodules = bool<br>    }))<br>    auth = list(object({<br>      type     = string<br>      resource = string<br>    }))<br>  }))</pre> | n/a | yes |
| service\_role | The Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) role that enables AWS CodeBuild to interact with dependent AWS services on behalf of the AWS account | `string` | n/a | yes |
| source\_version | A version of the build input to be built for this project. If not specified, the latest version is used | `string` | n/a | yes |
| vpc\_config | Configuration for the builds to run inside a VPC. VPC config blocks are documented below | <pre>list(object({<br>    security_group_ids = list(string)<br>    subnets            = list(string)<br>    vpc_id             = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the CodeBuild project |
| id | The name (if imported via name) or ARN (if created via Terraform or imported via ARN) of the CodeBuild project |