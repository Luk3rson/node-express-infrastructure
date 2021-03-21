## Purpose
1. The implementation of documentdb cluster
2. The implementation of subnet group
3. The implementation of parameter group
4. The implementation of cluster instance

## Usage example
```
module "documentdb" {
  source = "../../modules/storage/documentdb"

  #DocumentDB cluster
  enabled                         = true
  apply_immediately               = false
  availability_zones              = ["eu-central-1a", "eu-central-1b"]
  backup_retention_period         = 7
  enabled_cloudwatch_logs_exports = ["audit"]
  engine_version                  = ""
  engine                          = "docdb"
  final_snapshot_identifier       = true
  kms_key_id                      = ""
  port                            = 27017
  preferred_backup_window         = "02:00-03:00"
  skip_final_snapshot             = true
  snapshot_identifier             = true
  storage_encrypted               = false
  vpc_security_group_ids          = [sg_id]
  master_password                 = pass
  master_username                 = username

  #DocumentDB Cluster instances
  instance_class               = "db.r5.large"
  auto_minor_version_upgrade   = false
  preferred_maintenance_window = "Mon:00:00-Mon:02:00"
  promotion_tier               = 0
  number_of_instances          = 1

  #DocumentDB cluster subnet group
  subnet_group_description = "Foo"
  subnet_group_subnet_ids  = [subnet_ids]

  #DocumentDB cluster parameters group
  db_instance_availability_zone = ""
  parameter_group_description = "Managed by Terraform"
  parameter_group_parameters  = []
  parameter_group_family      = "docdb3.6"

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
| apply\_immediately | Specifies whether any cluster modifications are applied immediately, or during the next maintenance window | `bool` | n/a | yes |
| auto\_minor\_version\_upgrade | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window | `bool` | n/a | yes |
| availability\_zones | A list of EC2 Availability Zones that instances in the DB cluster can be created in | `list(string)` | n/a | yes |
| backup\_retention\_period | The days to retain backups for | `number` | n/a | yes |
| db\_instance\_availability\_zone | The EC2 Availability Zone that the DB instance is created in. See docs about the details | `string` | n/a | yes |
| enabled | Create new documentdb cluster | `bool` | n/a | yes |
| enabled\_cloudwatch\_logs\_exports | List of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: audit, profiler | `list(string)` | n/a | yes |
| engine | The name of the database engine to be used for this DB cluster. | `string` | n/a | yes |
| engine\_version | The database engine version. Updating this argument results in an outage | `string` | n/a | yes |
| final\_snapshot\_identifier | The name of your final DB snapshot when this DB cluster is deleted. If omitted, no final snapshot will be made | `string` | n/a | yes |
| instance\_class | The instance class to use | `string` | n/a | yes |
| kms\_key\_id | The ARN for the KMS encryption key. When specifying kms\_key\_id, storage\_encrypted needs to be set to true | `string` | n/a | yes |
| master\_password | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file | `string` | n/a | yes |
| master\_username | Username for the master DB user | `string` | n/a | yes |
| naming\_additional\_attributes | Additional attributes (e.g. `policy` or `role`) | `list` | n/a | yes |
| naming\_additional\_tags | Additional tags (e.g. `map('BusinessUnit`,`XYZ`) | `map` | n/a | yes |
| naming\_delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | n/a | yes |
| naming\_environment\_name | Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared' | `string` | n/a | yes |
| naming\_ext | extension to the full name, e.g. Sequence or additional name | `string` | n/a | yes |
| naming\_oe | Organisational entity name | `string` | n/a | yes |
| naming\_project\_name | Project name if projects has it's own environment | `string` | n/a | yes |
| number\_of\_instances | Number of instances in cluster | `number` | n/a | yes |
| parameter\_group\_description | The description of the documentDB cluster parameter group. Defaults to Managed by Terraform | `string` | n/a | yes |
| parameter\_group\_family | The family of the documentDB cluster parameter group | `string` | n/a | yes |
| parameter\_group\_parameters | List of DB parameters to apply | <pre>list(object({<br>    apply_method = string<br>    name         = string<br>    value        = string<br>  }))</pre> | n/a | yes |
| port | The port on which the DB accepts connections | `number` | n/a | yes |
| preferred\_backup\_window | The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC | `string` | n/a | yes |
| preferred\_maintenance\_window | The window to perform maintenance in. Syntax: ddd:hh24:mi-ddd:hh24:mi. Eg: Mon:00:00-Mon:03:00 | `string` | n/a | yes |
| promotion\_tier | Failover Priority setting on instance level. The reader who has lower tier has higher priority to get promoter to writer | `number` | n/a | yes |
| skip\_final\_snapshot | Determines whether a final DB snapshot is created before the DB cluster is deleted. If true is specified, no DB snapshot is created. If false is specified, a DB snapshot is created before the DB cluster is deleted, using the value from final\_snapshot\_identifier | `bool` | n/a | yes |
| snapshot\_identifier | Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot | `string` | n/a | yes |
| storage\_encrypted | Specifies whether the DB cluster is encrypted | `bool` | n/a | yes |
| subnet\_group\_description | The description of the docDB subnet group. Defaults to Managed by Terraform | `string` | n/a | yes |
| subnet\_group\_subnet\_ids | A list of VPC subnet IDs | `list(string)` | n/a | yes |
| vpc\_security\_group\_ids | List of VPC security groups to associate with the Cluster | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | Amazon Resource Name (ARN) of cluster |
| cluster\_members | List of DocDB Instances that are a part of this cluster |
| cluster\_resource\_id | The DocDB Cluster Resource ID |
| endpoint | The DNS address of the DocDB instance |
| hosted\_zone\_id | The Route53 Hosted Zone ID of the endpoint |
| id | The DocDB Cluster Identifier |