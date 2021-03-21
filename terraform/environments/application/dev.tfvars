# Provider
region                  = "us-east-1"
bucket                  = "web-app-terraform-state-dev"

# Naming
naming_oe               = "lupho"
naming_project_name     = "web"
naming_environment_name = "dev"

# DocumentDB
web_portal_docdb_retention_period                        = 7
web_portal_docdb_engine_version                          = ""
web_portal_docdb_preferred_backup_window                 = "02:00-03:00"
web_portal_docdb_instance_class                          = "db.r5.large"
web_portal_docdb_instance_preferred_maintenance_window   = "Mon:00:00-Mon:02:00"
web_portal_docdb_number_of_instances                     = 1

web_portal_docdb_apply_cluster_modifications_immediately = false
web_portal_docdb_final_snapshot_identifier               = "documentdb-final-snapshot-dev"
web_portal_docdb_snapshot_identifier                     = ""

#ECS Web Portal Cluster
ecs_web_portal_task_definition_cpu             = 2048
ecs_web_portal_task_definition_memory          = 4096
ecs_web_portal_container_log_retention_in_days = 7
ecs_web_portal_container_cpu                   = 1024
ecs_web_portal_container_memory                = 2028
ecs_web_portal_container_name                  = "web-portal"

#ECS Web Portal service
ecs_web_portal__service_desired_count          = 1
ecs_web_portal_service_name                    = "web-portal"
ecs_web_portal_service_port                    = 8080

ecs_web_portal_name                            = "web-portal-cluster"