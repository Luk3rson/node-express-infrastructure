################################################################################################
# DocumentDB variables
################################################################################################
variable "enabled" {
  type        = bool
  description = "Create new documentdb cluster"
}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window"
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of EC2 Availability Zones that instances in the DB cluster can be created in"
}

variable "backup_retention_period" {
  type        = number
  description = "The days to retain backups for"
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "List of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: audit, profiler"
}

variable "engine_version" {
  type        = string
  description = "The database engine version. Updating this argument results in an outage"
}

variable "engine" {
  type        = string
  description = "The name of the database engine to be used for this DB cluster."
}

variable "final_snapshot_identifier" {
  type        = string
  description = "The name of your final DB snapshot when this DB cluster is deleted. If omitted, no final snapshot will be made"
}

variable "kms_key_id" {
  type        = string
  description = "The ARN for the KMS encryption key. When specifying kms_key_id, storage_encrypted needs to be set to true"
}

variable "master_password" {
  type        = string
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
}

variable "master_username" {
  type        = string
  description = "Username for the master DB user"
}

variable "port" {
  type        = number
  description = "The port on which the DB accepts connections"
}
variable "preferred_backup_window" {
  type        = string
  description = "The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted. If true is specified, no DB snapshot is created. If false is specified, a DB snapshot is created before the DB cluster is deleted, using the value from final_snapshot_identifier"
}

variable "snapshot_identifier" {
  type        = string
  description = "Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot"
}

variable "storage_encrypted" {
  type        = bool
  description = "Specifies whether the DB cluster is encrypted"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of VPC security groups to associate with the Cluster"
}

################################################################################################
# DocumentDB Subnet group variables
################################################################################################

variable "subnet_group_description" {
  type        = string
  description = "The description of the docDB subnet group. Defaults to Managed by Terraform"
}

variable "subnet_group_subnet_ids" {
  type        = list(string)
  description = "A list of VPC subnet IDs"
}

################################################################################################
# DocumentDB Parameter group variables
################################################################################################
variable "parameter_group_family" {
  type        = string
  description = "The family of the documentDB cluster parameter group"
}

variable "parameter_group_description" {
  type        = string
  description = "The description of the documentDB cluster parameter group. Defaults to Managed by Terraform"
}

variable "parameter_group_parameters" {
  type = list(object({
    apply_method = string
    name         = string
    value        = string
  }))
  description = "List of DB parameters to apply"
}

################################################################################################
# DocumentDB Instance variables
################################################################################################
variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
}

variable "instance_class" {
  type        = string
  description = "The instance class to use"
}

variable "preferred_maintenance_window" {
  type        = string
  description = "The window to perform maintenance in. Syntax: ddd:hh24:mi-ddd:hh24:mi. Eg: Mon:00:00-Mon:03:00"
}

variable "promotion_tier" {
  type        = number
  description = "Failover Priority setting on instance level. The reader who has lower tier has higher priority to get promoter to writer"
}

variable "number_of_instances" {
  type        = number
  description = "Number of instances in cluster"
}

variable "db_instance_availability_zone" {
  type        = string
  description = "The EC2 Availability Zone that the DB instance is created in. See docs about the details"
}