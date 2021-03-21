############################################################################################################
# ECR Repository
############################################################################################################
module "ecr_web_portal_repository" {
  source = "../../modules/containers/ecr"

  enabled                      = local.create_ecr_web_portal_repository
  image_tag_mutability         = local.ecr_web_portal_repo_image_tag_mutability
  image_scanning_web_portal    = local.ecr_web_portal_repo_image_scanning_web_portal
  repo_policy                  = local.ecr_web_portal_repo_repo_policy
  repo_lifecycle_policy        = local.ecr_web_portal_repo_repo_lifecycle_policy
  image_scanning_configuration = []

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_ext                   = local.ecr_web_portal_naming_ext
  naming_delimiter             = local.ecr_web_portal_naming_delimiter
  naming_additional_attributes = local.ecr_web_portal_naming_additional_attributes
  naming_additional_tags       = local.ecr_web_portal_naming_additional_tags
}


############################################################################################################
# ECS task definition
############################################################################################################
#------------------------------
# ECS task template role policy
#------------------------------
data "template_file" "ecs_web_portal_task_role_policy" {
  template = file("templates/ecs_web_portal_task_role_policy.json")
  vars = { }
}

#------------------------------
# ECS task role
#------------------------------
module "ecs_web_portal_task_role" {
  source                             = "../../modules/iam/assumable_role"
  assume_role_iam_policy_identifiers = local.ecs_web_portal_task_role_assume_role_iam_policy_identifiers
  iam_policy_arns                    = lookup(local.workspace, "ecs_web_portal_task_role_iam_policy_arns")
  role_policy                        = data.template_file.ecs_web_portal_task_role_policy.rendered
  role_policy_count                  = 1
  force_detach_policies              = local.ecs_web_portal_task_role_force_detach_policies
  description                        = local.ecs_web_portal_task_role_description
  max_session_duration               = local.ecs_web_portal_task_role_max_session_duration
  policy_description                 = local.ecs_web_portal_task_role_policy_description
  number_of_attached_policies        = 2

  #Naming
  naming_oe                           = var.naming_oe
  naming_project_name                 = var.naming_project_name
  naming_environment_name             = var.naming_environment_name
  naming_ext                          = local.ecs_web_portal_task_role_naming_ext
  naming_delimiter                    = local.ecs_web_portal_task_role_naming_delimiter
  naming_additional_attributes        = local.ecs_web_portal_task_role_naming_additional_attributes
  naming_additional_tags              = local.ecs_web_portal_task_role_naming_additional_tags
  naming_policy_additional_attributes = local.ecs_web_portal_task_role_naming_policy_additional_attributes
}

#------------------------------
# ECS task execution role
#------------------------------
module "ecs_web_portal_execution_role" {
  source                             = "../../modules/iam/assumable_role"
  assume_role_iam_policy_identifiers = local.ecs_web_portal_task_execution_assume_role_iam_policy_identifiers
  iam_policy_arns                    = lookup(local.workspace, "ecs_web_portal_task_role_iam_policy_arns")
  role_policy                        = ""
  role_policy_count                  = 0
  force_detach_policies              = local.ecs_web_portal_task_execution_force_detach_policies
  description                        = local.ecs_web_portal_task_execution_role_description
  max_session_duration               = local.ecs_web_portal_task_execution_max_session_duration
  policy_description                 = local.ecs_web_portal_task_execution_policy_description
  number_of_attached_policies        = 1

  #Naming
  naming_oe                           = var.naming_oe
  naming_project_name                 = var.naming_project_name
  naming_environment_name             = var.naming_environment_name
  naming_ext                          = local.ecs_web_portal_task_execution_role_naming_ext
  naming_delimiter                    = local.ecs_web_portal_task_execution_role_naming_delimiter
  naming_additional_attributes        = local.ecs_web_portal_task_execution_role_naming_additional_attributes
  naming_additional_tags              = local.ecs_web_portal_task_execution_role_naming_additional_tags
  naming_policy_additional_attributes = local.ecs_web_portal_task_execution_role_naming_policy_additional_attributes
}

#------------------------------
# ECS task
#------------------------------
module "ecs_web_portal_task_definition" {
  source  = "../../modules/containers/ecs/task_definition"
  enabled = local.create_ecs_web_portal_task_definition

  inference_accelerator    = local.ecs_web_portal_task_inference_accelerator
  proxy_configuration      = local.ecs_web_portal_task_proxy_configuration
  placement_constraints    = local.ecs_web_portal_task_placement_constraints
  docker_volumes           = local.ecs_web_portal_task_docker_volumes
  efs_volumes              = local.ecs_web_portal_task_efs_volumes
  container_definitions    = format("[%s, %s]", module.ecs_web_portal_container_definition.container_definition)
  task_role_arn            = module.ecs_web_portal_task_role.role_arn
  execution_role_arn       = module.ecs_web_portal_execution_role.role_arn
  network_mode             = local.ecs_web_portal_task_network_mode
  ipc_mode                 = local.ecs_web_portal_task_ipc_mode
  pid_mode                 = local.ecs_web_portal_task_pid_mode
  cpu                      = var.ecs_web_portal_task_definition_cpu
  memory                   = var.ecs_web_portal_task_definition_memory
  requires_compatibilities = local.ecs_web_portal_task_requires_compatibilities

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_ext                   = local.ecs_web_portal_task_naming_ext
  naming_delimiter             = local.ecs_web_portal_task_naming_delimiter
  naming_additional_attributes = local.ecs_web_portal_task_naming_additional_attributes
  naming_additional_tags       = local.ecs_web_portal_task_naming_additional_tags
}

############################################################################################################
# ECS container definition
############################################################################################################
#------------------------------
# Container log group
#------------------------------
module "ecs_web_portal_container_log_group" {
  source            = "../../modules/cloudwatch/loggroup"
  enabled           = local.create_ecs_web_portal_container_log_group
  retention_in_days = var.ecs_web_portal_container_log_retention_in_days
  kms_key_id        = local.ecs_web_portal_container_log_kms_key_id

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_ext                   = local.ecs_web_portal_container_log_naming_ext
  naming_delimiter             = local.ecs_web_portal_container_log_naming_delimiter
  naming_additional_attributes = local.ecs_web_portal_container_log_additional_attributes
  naming_additional_tags       = local.ecs_web_portal_container_log_additional_tags
}

#------------------------------
# Container definition
#------------------------------
module "ecs_web_portal_container_definition" {
  source                 = "../../modules/containers/ecs/container_definition"
  dnsSearchDomains       = local.ecs_web_portal_container_dnsSearchDomains
  logConfiguration       = local.ecs_web_portal_container_logconfiguration
  entryPoint             = local.ecs_web_portal_container_entryPoint
  portMappings           = local.ecs_web_portal_container_portMappings
  command                = local.ecs_web_portal_container_command
  linuxParameters        = local.ecs_web_portal_container_linuxParameters
  cpu                    = var.ecs_web_portal_container_cpu
  environment            = local.ecs_web_portal_container_environment
  resourceRequirements   = local.ecs_web_portal_container_resourceRequirements
  ulimits                = local.ecs_web_portal_container_ulimits
  dnsServers             = local.ecs_web_portal_container_dnsServers
  mountPoints            = local.ecs_web_portal_container_mountPoints
  workingDirectory       = local.ecs_web_portal_container_workingDirectory
  secrets                = local.ecs_web_portal_container_secrets
  dockerSecurityOptions  = local.ecs_web_portal_container_dockerSecurityOptions
  memory                 = var.ecs_web_portal_container_memory
  memoryReservation      = local.ecs_web_portal_container_memoryReservation
  volumesFrom            = local.ecs_web_portal_container_volumesFrom
  stopTimeout            = local.ecs_web_portal_container_stopTimeout
  image                  = module.ecr_web_portal_repository.repository_url[0]
  startTimeout           = local.ecs_web_portal_container_startTimeout
  dependsOn              = local.ecs_web_portal_container_dependsOn
  disableNetworking      = local.ecs_web_portal_container_disableNetworking
  interactive            = local.ecs_web_portal_container_interactive
  healthCheck            = local.ecs_web_portal_container_healthCheck
  essential              = local.ecs_web_portal_container_essential
  links                  = local.ecs_web_portal_container_links
  hostname               = local.ecs_web_portal_container_hostname
  extraHosts             = local.ecs_web_portal_container_extraHosts
  pseudoTerminal         = local.ecs_web_portal_container_pseudoTerminal
  user                   = local.ecs_web_portal_container_user
  readonlyRootFilesystem = local.ecs_web_portal_container_readonlyRootFilesystem
  dockerLabels           = local.ecs_web_portal_container_dockerLabels
  systemControls         = local.ecs_web_portal_container_systemControls
  privileged             = local.ecs_web_portal_container_privileged
  name                   = var.ecs_web_portal_container_name
}

############################################################################################################
# Application load balancer
############################################################################################################
#------------------------------
# Security group
#------------------------------
module "web_portal_alb_sg" {
  source            = "../../modules/network/security_groups"
  vpcid             = data.terraform_remote_state.network.outputs.vpc_id
  sgdescription     = local.web_portal_alb_sgdescription
  sg_in_cidr_rules  = local.web_portal_alb_sg_in_cidr_rules
  sg_eg_cidr_rules  = local.web_portal_alb_sg_eg_cidr_rules
  sg_in_sgsrc_rules = local.web_portal_alb_sg_in_sgsrc_rules
  sg_eg_sgsrc_rules = local.web_portal_alb_sg_eg_sgsrc_rules
  sg_insrc_count    = 0

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_ext                   = local.web_portal_alb_sg_naming_ext
  naming_delimiter             = local.web_portal_alb_sg_naming_delimiter
  naming_additional_attributes = local.web_portal_alb_sg_naming_additional_attributes
  naming_additional_tags       = local.web_portal_alb_sg_naming_additional_tags
}

#------------------------------
# ALB
#------------------------------
module "web_portal_alb" {
  source = "../../modules/compute/ecs_service_alb"

  lb_security_groups          = [module.web_portal_alb_sg.sg_id]
  lb_internal                 = local.web_portal_alb_internal
  lb_subnets                  = data.terraform_remote_state.network.outputs.public_subnets
  lb_deletion_protection      = local.web_portal_alb_deletion_protection
  lb_idle_timeout             = local.web_portal_alb_idle_timeout
  lb_tg_vpc                   = data.terraform_remote_state.network.outputs.vpc_id
  target_groups               = local.web_portal_alb_target_groups
  load_balancer_listener      = local.web_portal_alb_load_balancer_listener
  load_balancer_listener_rule = local.web_portal_alb_load_balancer_listener_rule

  #Naming
  naming_oe                       = var.naming_oe
  naming_project_name             = var.naming_project_name
  naming_environment_name         = var.naming_environment_name
  naming_ext                      = local.web_portal_alb_naming_ext
  naming_delimiter                = local.web_portal_alb_naming_delimiter
  naming_additional_attributes    = local.web_portal_alb_naming_additional_attributes
  naming_tg_additional_attributes = local.web_portal_alb_naming_tg_additional_attributes
  naming_additional_tags          = local.web_portal_alb_naming_additional_tags
}

############################################################################################################
# ECS Cluster
############################################################################################################
module "ecs_web_portal_cluster" {
  source = "../../modules/containers/ecs/cluster"

  enabled                            = local.create_ecs_web_portal_cluster
  capacity_providers                 = local.ecs_web_portal_capacity_providers
  default_capacity_provider_strategy = local.ecs_web_portal_default_capacity_provider_strategy
  settings                           = local.ecs_web_portal_cluster_settings

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_ext                   = local.ecs_web_portal_naming_ext
  naming_delimiter             = local.ecs_web_portal_naming_delimiter
  naming_additional_attributes = local.ecs_web_portal_naming_additional_attributes
  naming_additional_tags       = local.ecs_web_portal_naming_additional_tags

}

############################################################################################################
# ECS service
############################################################################################################
#------------------------------
# Security group
#------------------------------
module "ecs_web_portal_sg" {
  source            = "../../modules/network/security_groups"
  vpcid             = data.terraform_remote_state.network.outputs.vpc_id
  sgdescription     = local.web_portal_sg_description
  sg_in_cidr_rules  = local.web_portal_sg_in_cidr_rules
  sg_eg_cidr_rules  = local.web_portal_sg_eg_cidr_rules
  sg_in_sgsrc_rules = local.web_portal_sg_in_sgsrc_rules
  sg_eg_sgsrc_rules = local.web_portal_sg_eg_sgsrc_rules
  sg_insrc_count    = 0

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_ext                   = local.web_portal_sg_naming_ext
  naming_delimiter             = local.web_portal_sg_naming_delimiter
  naming_additional_attributes = local.web_portal_sg_naming_additional_attributes
  naming_additional_tags       = local.web_portal_sg_naming_additional_tags
}

#------------------------------
# ECS Service
#------------------------------
module "ecs_web_portal" {
  source                             = "../../modules/containers/ecs/service"
  enabled                            = local.deploy_web_portal
  name                               = var.ecs_web_portal_name
  cluster                            = element(lookup(module.ecs_web_portal_cluster, "arn"), 0)
  deployment_maximum_percent         = local.ecs_web_portal_deployment_maximum_percent
  deployment_minimum_healthy_percent = local.ecs_web_portal_deployment_minimum_healthy_percent
  desired_count                      = var.ecs_web_portal_desired_count
  enable_ecs_managed_tags            = local.ecs_web_portal_enable_managed_tags
  force_new_deployment               = local.ecs_web_portal_force_new_deployment
  health_check_grace_period_seconds  = local.ecs_web_portal_health_check_grace_period_seconds
  iam_role                           = local.ecs_web_portal_iam_role
  launch_type                        = local.ecs_web_portal_launch_type
  platform_version                   = local.ecs_web_portal_platform_version
  propagate_tags                     = local.ecs_web_portal_propagate_tags
  scheduling_strategy                = local.ecs_web_portal_scheduling_strategy
  task_definition                    = join("-", ["lupho", var.naming_project_name, "ue1", terraform.workspace, "task", "web-portal"])
  capacity_provider_strategy         = local.ecs_web_portal_capacity_provider_strategy
  deployment_controller              = local.ecs_web_portal_deployment_controller
  load_balancer                      = local.ecs_web_portal_load_balancer
  network_configuration              = local.ecs_web_portal_network_configuration
  ordered_placement_strategy         = local.ecs_web_portal_ordered_placement_strategy
  placement_constraints              = local.ecs_web_portal_placement_constraints
  service_registries                 = local.ecs_web_portal_service_registries

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_ext                   = local.ecs_web_portal_naming_ext
  naming_delimiter             = local.ecs_web_portal_naming_delimiter
  naming_additional_attributes = local.ecs_web_portal_naming_additional_attributes
  naming_additional_tags       = local.ecs_web_portal_naming_additional_tags
}

############################################################################################################
# CodeDeploy
############################################################################################################
#------------------------------
# Role
#------------------------------
module "codedeploy_web_portal_cb_role" {
  source                             = "../../modules/iam/assumable_role"
  assume_role_iam_policy_identifiers = local.codedeploy_web_portal_assume_role_iam_policy_identifiers
  iam_policy_arns                    = local.codedeploy_web_portal_iam_policy_arns
  role_policy                        = data.template_file.codedeploy_web_portal_role.rendered
  role_policy_count                  = 1
  force_detach_policies              = local.codedeploy_web_portal_force_detach_policies
  description                        = local.codedeploy_web_portal_role_description
  max_session_duration               = local.codedeploy_web_portal_max_session_duration
  policy_description                 = local.codedeploy_web_portal_policy_description
  number_of_attached_policies        = 1

  #Naming
  naming_oe                           = var.naming_oe
  naming_project_name                 = var.naming_project_name
  naming_environment_name             = var.naming_environment_name
  naming_ext                          = local.codedeploy_web_portal_role_naming_ext
  naming_delimiter                    = local.codedeploy_web_portal_role_naming_delimiter
  naming_additional_attributes        = local.codedeploy_web_portal_role_naming_additional_attributes
  naming_additional_tags              = local.codedeploy_web_portal_role_naming_additional_tags
  naming_policy_additional_attributes = local.codedeploy_web_portal_role_naming_policy_additional_attributes
}

data "template_file" "codedeploy_web_portal_role" {
  template = file("templates/codedeploy_web_portal_role_policy.json.tpl")
}

#------------------------------
# CodeDeploy
#------------------------------
module "codedeploy_web_portal" {
  source                       = "../../modules/development/codedeploy"
  enabled                      = local.deploy_web_portal_codedeploy
  compute_platform             = local.web_portal_cd_compute_platform
  service_role_arn             = module.codedeploy_web_portal_cb_role.role_arn
  autoscaling_groups           = local.codedeploy_web_portal_cd_autoscaling_groups
  deployment_config_name       = local.codedeploy_web_portal_cd_deployment_config_name
  alarm_configuration          = local.codedeploy_web_portal_cd_alarm_web_portal
  auto_rollback_configuration  = local.codedeploy_web_portal_cd_auto_rollback_web_portal
  blue_green_deployment_config = local.codedeploy_web_portal_cd_blue_green_deployment_config
  deployment_style             = local.codedeploy_web_portal_cd_deployment_style
  ecs_service                  = local.codedeploy_web_portal_cd_ecs_service
  load_balancer_info           = local.codedeploy_web_portal_cd_load_balancer_info
  trigger_configuration        = local.codedeploy_web_portal_cd_trigger_web_portal


  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_ext                   = local.codedeploy_web_portal_naming_ext
  naming_delimiter             = local.codedeploy_web_portal_naming_delimiter
  naming_additional_attributes = local.codedeploy_web_portal_naming_additional_attributes
  naming_additional_tags       = local.codedeploy_web_portal_naming_additional_tags
}

############################################################################################################
# DocumentDB
############################################################################################################
module "web_portal_docdb" {
  source = "../../modules/storage/documentdb"

  #DocumentDB cluster
  enabled                         = local.web_portal_docdb_create
  apply_immediately               = var.web_portal_docdb_apply_cluster_modifications_immediately
  availability_zones              = [element(local.web_portal_docdb_availability_zones, 0), element(local.web_portal_docdb_availability_zones, 1),
    element(local.web_portal_docdb_availability_zones, 2)]
  backup_retention_period         = var.web_portal_docdb_retention_period
  enabled_cloudwatch_logs_exports = local.web_portal_docdb_enabled_cloudwatch_logs_exports
  engine_version                  = var.web_portal_docdb_engine_version
  engine                          = local.web_portal_docdb_engine
  final_snapshot_identifier       = var.web_portal_docdb_final_snapshot_identifier
  kms_key_id                      = local.web_portal_docdb_kms_key_id
  port                            = local.web_portal_docdb_port
  preferred_backup_window         = var.web_portal_docdb_preferred_backup_window
  snapshot_identifier             = var.web_portal_docdb_snapshot_identifier
  storage_encrypted               = local.web_portal_docdb_storage_encrypted
  vpc_security_group_ids          = [module.web_portal_docdb_sg.sg_id]
  master_password                 = module.web_portal_docdb_user.value
  master_username                 = module.web_portal_docdb_user.name

  #DocumentDB Cluster instances
  instance_class               = var.web_portal_docdb_instance_class
  auto_minor_version_upgrade   = local.web_portal_docdb_auto_minor_version_upgrade
  preferred_maintenance_window = var.web_portal_docdb_instance_preferred_maintenance_window
  promotion_tier               = local.web_portal_docdb_promotion_tier
  number_of_instances          = var.web_portal_docdb_number_of_instances

  #DocumentDB cluster subnet group
  subnet_group_description = local.web_portal_docdb_subnet_group_description
  subnet_group_subnet_ids  = data.terraform_remote_state.network.outputs.private_subnets

  #DocumentDB cluster parameters group
  parameter_group_family        = local.web_portal_docdb_parameter_group_family
  parameter_group_description   = local.web_portal_docdb_parameter_group_description
  parameter_group_parameters    = local.web_portal_docdb_parameter_group_parameters
  db_instance_availability_zone = local.web_portal_docdb_instance_availability_zone
  skip_final_snapshot           = true

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_ext                   = local.web_portal_docdb_naming_ext
  naming_delimiter             = local.web_portal_docdb_naming_delimiter
  naming_additional_attributes = local.web_portal_docdb_naming_additional_attributes
  naming_additional_tags       = local.web_portal_docdb_naming_additional_tags
}

module "web_portal_docdb_sg" {
  source = "../../modules/network/security_groups"
  vpcid                        = data.terraform_remote_state.network.outputs.vpc_id
  sg_eg_cidr_rules             = local.web_portal_docdb_sg_eg_cidr_rules
  sg_in_cidr_rules             = local.web_portal_docdb_sg_in_cidr_rules
  sg_eg_sgsrc_rules            = local.web_portal_docdb_sg_eg_sgsrc_rules
  sg_in_sgsrc_rules            = local.web_portal_docdb_sg_in_sgsrc_rules
  sgdescription                = local.web_portal_docdb_sgdescription

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_ext                   = local.web_portal_docdb_sg_naming_ext
  naming_delimiter             = local.web_portal_docdb_sg_naming_delimiter
  naming_additional_attributes = local.web_portal_docdb_sg_naming_additional_attributes
  naming_additional_tags       = local.web_portal_docdb_sg_naming_additional_tags
}