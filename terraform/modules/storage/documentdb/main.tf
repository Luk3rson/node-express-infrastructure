################################################################################################
# DocumentDB resource
################################################################################################
module "db_naming" {
  source      = "../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_docdb_role_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_docdb_cluster" "db" {
  count                           = var.enabled ? 1 : 0
  apply_immediately               = var.apply_immediately
  availability_zones              = var.availability_zones
  backup_retention_period         = var.backup_retention_period
  cluster_identifier              = module.db_naming.id
  db_subnet_group_name            = local.db_subnet_group_name
  db_cluster_parameter_group_name = local.db_cluster_parameter_group_name
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  engine_version                  = var.engine_version
  engine                          = var.engine
  final_snapshot_identifier       = var.final_snapshot_identifier
  kms_key_id                      = var.kms_key_id
  master_password                 = var.master_password
  master_username                 = var.master_username
  port                            = var.port
  preferred_backup_window         = var.preferred_backup_window
  skip_final_snapshot             = var.skip_final_snapshot
  snapshot_identifier             = var.snapshot_identifier
  storage_encrypted               = var.storage_encrypted
  vpc_security_group_ids          = var.vpc_security_group_ids

  tags = module.db_naming.tags

  lifecycle {
        ignore_changes = ["availability_zones"]
  }
}

################################################################################################
# DocumentDB Subnet group resource
################################################################################################
resource "aws_docdb_subnet_group" "subnet_group" {
  count       = var.enabled ? 1 : 0
  name        = module.db_naming.id
  description = var.subnet_group_description
  subnet_ids  = var.subnet_group_subnet_ids
  tags        = module.db_naming.tags
}

################################################################################################
# DocumentDB Parameter group resource
################################################################################################
resource "aws_docdb_cluster_parameter_group" "params" {
  count       = var.enabled ? 1 : 0
  name        = module.db_naming.id
  family      = var.parameter_group_family
  description = var.parameter_group_description

  dynamic "parameter" {
    for_each = var.parameter_group_parameters
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }

  tags = module.db_naming.tags

}

################################################################################################
# DocumentDB instance
################################################################################################
resource "aws_docdb_cluster_instance" "cluster_instances" {
  count                        = var.enabled && var.number_of_instances > 0 ? var.number_of_instances : 0
  apply_immediately            = var.apply_immediately
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  availability_zone            = var.db_instance_availability_zone
  cluster_identifier           = local.db_cluster_identifier
  engine                       = var.engine
  identifier                   = join(var.naming_delimiter, [module.db_naming.id, count.index + 1])
  instance_class               = var.instance_class
  preferred_maintenance_window = var.preferred_maintenance_window
  promotion_tier               = var.promotion_tier

  tags = module.db_naming.tags
}
