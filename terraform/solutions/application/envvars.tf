locals {
  env = {
    default = {
      apply_cluster_modifications_immediately = true
      final_snapshot_identifier               = ""
      skip_final_snapshot                     = true
      snapshot_identifier                     = ""
    }
    prod = {
      apply_cluster_modifications_immediately          = false
      final_snapshot_identifier                        = "documentdb-final-snapshot"
      skip_final_snapshot                              = false
      snapshot_identifier                              = ""
      ecs_web_portal_task_role_iam_policy_arns         = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
      docker_consolidation_cb_iam_policy_arns          = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"]
      docker_maintenance_cb_iam_policy_arns            = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"]
    }
    dev = {
      apply_cluster_modifications_immediately          = false
      final_snapshot_identifier                        = "documentdb-final-snapshot-dev"
      skip_final_snapshot                              = false
      snapshot_identifier                              = ""
      ecs_web_portal_task_role_iam_policy_arns         = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
      docker_consolidation_cb_iam_policy_arns          = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"]
      docker_maintenance_cb_iam_policy_arns            = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"]
    }
  }

  environmentvars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace       = merge(local.env["default"], local.env[local.environmentvars])
}
