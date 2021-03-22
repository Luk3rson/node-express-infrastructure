locals {
  role_name          = module.role_naming.id
  role_name_length   = length(local.role_name) > 31 ? 31 : length(local.role_name)
  naming_role_name   = "role"
  naming_policy_name = "policy"
  policy_arns        = var.role_policy != "" ? concat(var.iam_policy_arns, aws_iam_policy.policy[*].arn) : var.iam_policy_arns
}
