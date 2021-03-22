################################################################################################
# ECR repository resource
################################################################################################
module "ecr_repository_naming" {
  source      = "../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_ecr_repo_role_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_ecr_repository" "repo" {
  count                = var.enabled ? 1 : 0
  name                 = module.ecr_repository_naming.id
  image_tag_mutability = var.image_tag_mutability
  tags                 = module.ecr_repository_naming.tags
  dynamic "image_scanning_configuration" {
    for_each = length(var.image_scanning_configuration) > 0 ? var.image_scanning_configuration : []
    content {
      scan_on_push = image_scanning_configuration.value.scan_on_push
    }
  }
}

################################################################################################
# ECR repository policy resource
################################################################################################
resource "aws_ecr_repository_policy" "repo_policy" {
  count      = var.enabled && var.repo_policy != "" ? 1 : 0
  repository = aws_ecr_repository.repo[count.index].arn
  policy     = var.repo_policy
}

################################################################################################
# ECR repository policy resource
################################################################################################
resource "aws_ecr_lifecycle_policy" "repo_lc_policy" {
  count      = var.enabled && var.repo_lifecycle_policy != "" ? 1 : 0
  repository = aws_ecr_repository.repo[count.index].arn
  policy     = var.repo_lifecycle_policy
}
