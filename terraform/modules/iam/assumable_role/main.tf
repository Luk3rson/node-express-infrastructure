################################################################
# IAM role resource
################################################################
module "role_naming" {
  source      = "../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_role_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_iam_role" "role" {
  name_prefix           = substr(local.role_name, 0, local.role_name_length)
  assume_role_policy    = data.aws_iam_policy_document.iam_role_assume_role_policy_document.json
  force_detach_policies = var.force_detach_policies
  description           = var.description
  max_session_duration  = var.max_session_duration
  tags                  = module.role_naming.tags
}

################################################################
# IAM role policy resource
################################################################
module "role_policy_naming" {
  source      = "../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_policy_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = var.naming_policy_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_iam_policy" "policy" {
  count       = var.role_policy_count
  name        = module.role_policy_naming.id
  policy      = var.role_policy
  description = var.policy_description
}

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  role       = aws_iam_role.role.name
  count      = var.number_of_attached_policies
  policy_arn = local.policy_arns[count.index]

  depends_on = [aws_iam_policy.policy]
}

data "aws_iam_policy_document" "iam_role_assume_role_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = var.assume_role_iam_policy_identifiers
    }
  }
}
