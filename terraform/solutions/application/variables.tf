################################################################################################
# Global variables
################################################################################################

variable "region" {
  type        = string
  description = "The name of AWS region"
}

variable "bucket" {
  type = string
  description = "S3 backend bucket name"
}

################################################################################################
# Naming variables
################################################################################################
variable "naming_oe" {
  type        = string
  description = "Organisational entity name"
}

variable "naming_project_name" {
  type        = string
  description = "Project name if projects has it's own environment"
}

variable "naming_environment_name" {
  type        = string
  description = "Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared'"
}

################################################################################################
# DocumentDB variables
################################################################################################
variable "web_portal_docdb_retention_period" {
  type        = number
  description = "The days to retain backups for"
}

variable "web_portal_docdb_engine_version" {
  type        = string
  description = "The database engine version. Updating this argument results in an outage"
}

variable "web_portal_docdb_preferred_backup_window" {
  type        = string
  description = "The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC"
}

variable "web_portal_docdb_instance_class" {
  type        = string
  description = "The instance class to use"
}

variable "web_portal_docdb_instance_preferred_maintenance_window" {
  type        = string
  description = "The window to perform maintenance in. Syntax: ddd:hh24:mi-ddd:hh24:mi. Eg: Mon:00:00-Mon:03:00"
}

variable "web_portal_docdb_number_of_instances" {
  type        = number
  description = "Number of instances in cluster"
}

variable "web_portal_docdb_apply_cluster_modifications_immediately" {
  description = "Weather to apply changes immediately."
}

variable "web_portal_docdb_final_snapshot_identifier" {
  description = "Name of the final snapshot"
}

variable "web_portal_docdb_snapshot_identifier" {
  description = "Number of instances in cluster"
}

################################################################################################
# Consolidation variables
################################################################################################
#------------------------------
# ECS Task definition variables
#------------------------------
variable "ecs_web_portal_task_definition_cpu" {
  type        = number
  description = "The number of cpu units used by the task. If the requires_compatibilities is FARGATE this field is required"
}

variable "ecs_web_portal_task_definition_memory" {
  type        = number
  description = "The amount (in MiB) of memory used by the task. If the requires_compatibilities is FARGATE this field is required"
}

#------------------------------
# Container log group variables
#------------------------------

variable "ecs_web_portal_container_log_retention_in_days" {
  type        = number
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653."
}

#------------------------------
# Container variables
#------------------------------
variable "ecs_web_portal_container_cpu" {
  type        = number
  description = "Container definition CPU units"
}

variable "ecs_web_portal_container_memory" {
  type        = number
  description = "Container definition memory"
}

variable "ecs_web_portal_container_name" {
  type        = string
  description = "Name of the container"
}

#------------------------------
# Service variables
#------------------------------
variable "ecs_web_portal_desired_count" {
  description = "The number of instances of the task definition to place and keep running. Defaults to 0. Do not specify if using the DAEMON scheduling strategy"
  type        = number
}

variable "ecs_web_portal_name" {
  type        = string
  description = "The name of the ECS Service"
}

variable "ecs_web_portal_port" {
  type = number
  description = "Service container port"
}
