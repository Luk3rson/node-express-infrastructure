locals {
  #DocumentDB Cluster
  naming_docdb_role_name          = "docdb"
  db_subnet_group_name            = join("", aws_docdb_subnet_group.subnet_group.*.name) == "" ? null : join("", aws_docdb_subnet_group.subnet_group.*.name)
  db_cluster_parameter_group_name = join("", aws_docdb_cluster_parameter_group.params.*.name)
  db_cluster_identifier           = join("", aws_docdb_cluster.db.*.id)
}
