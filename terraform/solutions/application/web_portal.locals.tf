######################################################
# ECR Web Portal Repository
######################################################
locals {
  #ECR web_portal naming
  ecr_web_portal_naming_delimiter             = "-"
  ecr_web_portal_naming_ext                   = ""
  ecr_web_portal_naming_additional_attributes = ["web-portal"]
  ecr_web_portal_naming_additional_tags       = {}

  #ECR web_portal repository
  create_ecr_web_portal_repository                 = true
  ecr_web_portal_repo_image_tag_mutability         = "MUTABLE"
  ecr_web_portal_repo_repo_policy                  = ""
  ecr_web_portal_repo_repo_lifecycle_policy        = ""
}

######################################################
# ECS Web Portal cluster task
######################################################
locals {
  #ECS task role naming
  ecs_web_portal_task_role_naming_ext                          = "task"
  ecs_web_portal_task_role_naming_delimiter                    = "-"
  ecs_web_portal_task_role_naming_additional_attributes        = ["web-portal"]
  ecs_web_portal_task_role_naming_additional_tags              = {}
  ecs_web_portal_task_role_naming_policy_additional_attributes = ["web-portal"]

  #ECS task IAM Role
  ecs_web_portal_task_role_assume_role_iam_policy_identifiers = ["ecs-tasks.amazonaws.com"]
  ecs_web_portal_task_role_force_detach_policies              = false
  ecs_web_portal_task_role_description                        = "The role that is attached to ecs task"
  ecs_web_portal_task_role_max_session_duration               = 3600
  ecs_web_portal_task_role_policy_description                 = "The role policy that is attached to ecs task role"

  #ECS task execution role naming
  ecs_web_portal_task_execution_role_naming_ext                          = "task"
  ecs_web_portal_task_execution_role_naming_delimiter                    = "-"
  ecs_web_portal_task_execution_role_naming_additional_attributes        = ["web-portal"]
  ecs_web_portal_task_execution_role_naming_additional_tags              = {}
  ecs_web_portal_task_execution_role_naming_policy_additional_attributes = ["web-portal", "execution"]

  #ECS task execution role
  ecs_web_portal_task_execution_assume_role_iam_policy_identifiers = ["ecs-tasks.amazonaws.com"]
  ecs_web_portal_task_execution_force_detach_policies              = false
  ecs_web_portal_task_execution_role_description                   = "The role that is attached to ecs task execution"
  ecs_web_portal_task_execution_max_session_duration               = 3600
  ecs_web_portal_task_execution_policy_description                 = "The role policy that is attached to ecs task execution role"

  #ECS task definition naming
  ecs_web_portal_task_naming_delimiter             = "-"
  ecs_web_portal_task_naming_ext                   = "web-portal"
  ecs_web_portal_task_naming_additional_attributes = []
  ecs_web_portal_task_naming_additional_tags       = {}

  #ECS task definition
  create_ecs_web_portal_task_definition        = true
  ecs_web_portal_task_inference_accelerator    = []
  ecs_web_portal_task_proxy_configuration      = []
  ecs_web_portal_task_placement_constraints    = []
  ecs_web_portal_task_docker_volumes           = {}
  ecs_web_portal_task_efs_volumes              = {}
  ecs_web_portal_task_network_mode             = "awsvpc"
  ecs_web_portal_task_ipc_mode                 = null
  ecs_web_portal_task_pid_mode                 = null
  ecs_web_portal_task_requires_compatibilities = ["FARGATE"]
}

######################################################
# ECS Web Portal cluster container definition
######################################################
locals {
  #ECS container log group
  ecs_web_portal_container_log_naming_delimiter      = "/"
  ecs_web_portal_container_log_naming_ext            = "web-portal"
  ecs_web_portal_container_log_additional_attributes = []
  ecs_web_portal_container_log_additional_tags       = {}

  #ECS container log group
  create_ecs_web_portal_container_log_group = true
  ecs_web_portal_container_log_kms_key_id   = ""

  #Web Portal container definition
  ecs_web_portal_container_dnsSearchDomains = []
  ecs_web_portal_container_entryPoint       = []
  ecs_web_portal_container_logconfiguration = {
    logDriver     = "awslogs"
    secretOptions = []
    options = {
      awslogs-group         = module.ecs_web_portal_container_log_group.name,
      awslogs-region        = var.region,
      awslogs-stream-prefix = "ecs"
    }
  }
  ecs_web_portal_container_portMappings    = [
    {
      hostPort      = null
      protocol      = "tcp"
      containerPort = "8080"
    }
  ]
  ecs_web_portal_container_command         = []
  ecs_web_portal_container_linuxParameters = {}
  ecs_web_portal_container_environment = [
    {
      name  = "NODE_ENV"
      value = "production"
    },
    {
      name = "MONGODB_URI"
      value = "mongodb://lupho:${module.web_portal_docdb_user.value}@${module.web_portal_docdb[0].endpoint}:27017"
    }
  ]
  ecs_web_portal_container_resourceRequirements   = []
  ecs_web_portal_container_ulimits                = []
  ecs_web_portal_container_dnsServers             = []
  ecs_web_portal_container_mountPoints            = []
  ecs_web_portal_container_workingDirectory       = ""
  ecs_web_portal_container_secrets                = []
  ecs_web_portal_container_dockerSecurityOptions  = []
  ecs_web_portal_container_memoryReservation      = 0
  ecs_web_portal_container_volumesFrom            = []
  ecs_web_portal_container_stopTimeout            = 0
  ecs_web_portal_container_startTimeout           = 0
  ecs_web_portal_container_dependsOn              = []
  ecs_web_portal_container_disableNetworking      = false
  ecs_web_portal_container_interactive            = false
  ecs_web_portal_container_healthCheck            = null
  ecs_web_portal_container_essential              = true
  ecs_web_portal_container_links                  = []
  ecs_web_portal_container_extraHosts             = []
  ecs_web_portal_container_pseudoTerminal         = false
  ecs_web_portal_container_user                   = ""
  ecs_web_portal_container_readonlyRootFilesystem = false
  ecs_web_portal_container_dockerLabels           = {}
  ecs_web_portal_container_systemControls         = []
  ecs_web_portal_container_privileged             = false
  ecs_web_portal_container_hostname               = ""
}

######################################################
# Web Portal ALB
######################################################
locals {
  #Security group naming
  web_portal_alb_sg_naming_delimiter             = "-"
  web_portal_alb_sg_naming_ext                   = "webport"
  web_portal_alb_sg_naming_additional_attributes = []
  web_portal_alb_sg_naming_additional_tags       = {}

  #Security group
  web_portal_alb_sgdescription    = "Web Portal ALB security group"
  web_portal_alb_sg_in_cidr_rules = [

    {
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      from_port   = "80"
      to_port     = "80"
      description = "everyone"
    },
    {
      protocol    = "tcp"
      cidr_blocks = data.terraform_remote_state.network.outputs.vpc_cidr
      from_port   = "80"
      to_port     = "80"
      description = "Local VPC traffic"
    },
    {
      protocol    = "tcp"
      cidr_blocks = data.terraform_remote_state.network.outputs.vpc_cidr
      from_port   = "8080"
      to_port     = "8080"
      description = "Local VPC traffic"
    },
  ]
  web_portal_alb_sg_eg_cidr_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  web_portal_alb_sg_in_sgsrc_rules = []
  web_portal_alb_sg_eg_sgsrc_rules = []

  #ALB naming
  web_portal_alb_naming_delimiter                = "-"
  web_portal_alb_naming_ext                      = ""
  web_portal_alb_naming_additional_attributes    = ["webport"]
  web_portal_alb_naming_tg_additional_attributes = ["wp"]
  web_portal_alb_naming_additional_tags          = {}

  #ALB
  web_portal_alb_internal            = false
  web_portal_alb_deletion_protection = false
  web_portal_alb_idle_timeout        = 300
  web_portal_alb_target_groups = [
    {
      port                             = 8080
      protocol                         = "HTTP"
      target_type                      = "ip"
      health_check_enabled             = true
      health_check_healthy_threshold   = 5
      health_check_unhealthy_threshold = 5
      health_check_port                = 8080
      health_check_interval            = 300
      health_check_protocol            = "HTTP"
      health_check_path                = "/health"
      health_check_matcher             = "200"
      label                            = "80"
    },
    {
      port                             = 8080
      protocol                         = "HTTP"
      target_type                      = "ip"
      health_check_enabled             = true
      health_check_healthy_threshold   = 5
      health_check_unhealthy_threshold = 5
      health_check_port                = 8080
      health_check_interval            = 300
      health_check_protocol            = "HTTP"
      health_check_path                = "/health"
      health_check_matcher             = "200"
      label                            = "8080"
    }
  ]
  web_portal_alb_load_balancer_listener = [
    {
      load_balancer_listener_port                = 80
      load_balancer_listener_protocol            = "HTTP"
      load_balancer_listener_default_action_type = "forward"
    },
    {
      load_balancer_listener_port                = 8080
      load_balancer_listener_protocol            = "HTTP"
      load_balancer_listener_default_action_type = "forward"
    }
  ]
  web_portal_alb_load_balancer_listener_rule = {
    count = 0
    action_type = "forward"
  }
}

######################################################
# ECS Service
######################################################
locals {
  #Servic Naming
  ecs_web_portal_service_naming_ext                   = ""
  ecs_web_portal_service_naming_delimiter             = "-"
  ecs_web_portal_service_naming_additional_attributes = []
  ecs_web_portal_service_naming_additional_tags       = {}

  #ECS Service
  deploy_web_portal                                = true
  ecs_web_portal_deployment_maximum_percent         = 200
  ecs_web_portal_deployment_minimum_healthy_percent = 100
  ecs_web_portal_enable_managed_tags                = false
  ecs_web_portal_force_new_deployment               = false
  ecs_web_portal_health_check_grace_period_seconds  = 60
  ecs_web_portal_iam_role                           = null
  ecs_web_portal_launch_type                        = "FARGATE"
  ecs_web_portal_platform_version                   = "LATEST"
  ecs_web_portal_propagate_tags                     = null
  ecs_web_portal_scheduling_strategy                = "REPLICA"
  ecs_web_portal_capacity_provider_strategy         = []
  ecs_web_portal_deployment_controller = [
    {
      type = "CODE_DEPLOY"
    }
  ]
  ecs_web_portal_load_balancer = [
    {
      elb_name         = null
      target_group_arn = lookup(module.web_portal_alb, "lb_tg_id")
      container_name   = var.ecs_web_portal_container_name
      container_port   = "8080"
    }
  ]
  ecs_web_portal_network_configuration = [
    {
      subnets          = data.terraform_remote_state.network.outputs.private_subnets
      security_groups  = [module.ecs_web_portal_sg.sg_id]
      assign_public_ip = false
    }
  ]
  ecs_web_portal_ordered_placement_strategy = []
  ecs_web_portal_placement_constraints      = []
  ecs_web_portal_service_registries         = []

  #Security group
  web_portal_sg_description = "Access to the web portal"
  web_portal_sg_in_cidr_rules = [
    {
      protocol    = "tcp"
      cidr_blocks = data.terraform_remote_state.network.outputs.vpc_cidr
      from_port   = "8080"
      to_port     = "8080"
      description = "Local VPC traffic"
    },
  ]
  web_portal_sg_eg_cidr_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  web_portal_sg_in_sgsrc_rules = []
  web_portal_sg_eg_sgsrc_rules = []

  #Naming
  web_portal_sg_naming_delimiter             = "-"
  web_portal_sg_naming_ext                   = "web-portal"
  web_portal_sg_naming_additional_attributes = [""]
  web_portal_sg_naming_additional_tags       = {}
}

######################################################
# ECS LuPho cluster
######################################################
locals {
  #ECS Cluster
  create_ecs_web_portal_cluster                     = true
  ecs_web_portal_capacity_providers                 = ["FARGATE", "FARGATE_SPOT"]
  ecs_web_portal_default_capacity_provider_strategy = []
  ecs_web_portal_cluster_settings = [
    {
      name  = "containerInsights"
      value = "disabled"
    }
  ]

  #ECS Cluster naming
  ecs_web_portal_naming_delimiter             = "-"
  ecs_web_portal_naming_ext                   = ""
  ecs_web_portal_naming_additional_attributes = []
  ecs_web_portal_naming_additional_tags       = {}
}

######################################################
# CodeDeploy
######################################################
locals {
  #CodeDeploy
  deploy_web_portal_codedeploy                    = true
  web_portal_cd_compute_platform                  = "ECS"
  codedeploy_web_portal_cd_autoscaling_groups     = []
  codedeploy_web_portal_cd_deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  codedeploy_web_portal_cd_alarm_web_portal       = []
  codedeploy_web_portal_cd_trigger_web_portal     = []
  codedeploy_web_portal_cd_deployment_style = [
    {
      deployment_option = "WITH_TRAFFIC_CONTROL"
      deployment_type   = "BLUE_GREEN"
    }
  ]
  codedeploy_web_portal_cd_blue_green_deployment_config = [
    {
      deployment_ready_option = [
        {
          action_on_timeout    = "CONTINUE_DEPLOYMENT"
          wait_time_in_minutes = 0
        }
      ]
      green_fleet_provisioning_option = []
      terminate_blue_instances_on_deployment_success = [
        {
          action                           = "TERMINATE"
          termination_wait_time_in_minutes = 5
        }
      ]
    }
  ]
  codedeploy_web_portal_cd_auto_rollback_web_portal = [
    {
      enabled = true
      events  = ["DEPLOYMENT_FAILURE"]
    }
  ]

  codedeploy_web_portal_cd_ecs_service = [
    {
      cluster_name = module.ecs_web_portal_cluster.name
      service_name = var.ecs_web_portal_name
    }
  ]
  codedeploy_web_portal_cd_load_balancer_info = [
    {
      elb_info          = []
      target_group_info = []
      target_group_pair_info = [
        {
          prod_traffic_route = [
            {
              listener_arns = [element(lookup(module.web_portal_alb, "lb_listener_arns"), 0)]
            }
          ]
          target_group = [
            {
              name = element(lookup(module.web_portal_alb, "tg_names"), 0)
            },
            {
              name = element(lookup(module.web_portal_alb, "tg_names"), 1)
            }
          ]
          test_traffic_route = [
            {
              listener_arns = [element(lookup(module.web_portal_alb, "lb_listener_arns"), 1)]
            }
          ]
        }
      ]
    }
  ]

  #Naming CodeDeploy
  codedeploy_web_portal_naming_delimiter             = "-"
  codedeploy_web_portal_naming_ext                   = "web-portal"
  codedeploy_web_portal_naming_additional_attributes = ["service"]
  codedeploy_web_portal_naming_additional_tags       = {}

  #CodeDeploy IAM Role
  codedeploy_web_portal_assume_role_iam_policy_identifiers = ["codedeploy.amazonaws.com"]
  codedeploy_web_portal_force_detach_policies              = false
  codedeploy_web_portal_role_description                   = "The role that is attached to CodeDeploy"
  codedeploy_web_portal_max_session_duration               = 3600
  codedeploy_web_portal_policy_description                 = ""
  codedeploy_web_portal_iam_policy_arns                    = []

  #Naming Role
  codedeploy_web_portal_role_naming_ext                          = "cd"
  codedeploy_web_portal_role_naming_delimiter                    = "-"
  codedeploy_web_portal_role_naming_additional_attributes        = ["web-portal"]
  codedeploy_web_portal_role_naming_additional_tags              = {}
  codedeploy_web_portal_role_naming_policy_additional_attributes = ["web-portal"]
}

#####################################################
# DocumentDB
######################################################
locals {
  #DocumentDB Naming
  web_portal_docdb_naming_delimiter             = "-"
  web_portal_docdb_naming_ext                   = "web-portal"
  web_portal_docdb_naming_additional_attributes = []
  web_portal_docdb_naming_additional_tags       = {}

  #DocumentDB Security group naming
  web_portal_docdb_sg_naming_delimiter             = "-"
  web_portal_docdb_sg_naming_ext                   = "web-portal"
  web_portal_docdb_sg_naming_additional_attributes = ["docdb"]
  web_portal_docdb_sg_naming_additional_tags       = {}

  #DocumentDB Security group
  web_portal_docdb_sgdescription = "Security group for web portal DocumentDB cluster"
  web_portal_docdb_sg_in_cidr_rules = [
    {
      protocol    = "tcp"
      cidr_blocks = data.terraform_remote_state.network.outputs.vpc_cidr
      from_port   = 27017
      to_port     = 27017
      description = "Local VPC traffic"
    }
  ]
  web_portal_docdb_sg_eg_cidr_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  web_portal_docdb_sg_in_sgsrc_rules = []
  web_portal_docdb_sg_eg_sgsrc_rules = []

  #DocumentDB Cluster
  web_portal_docdb_create                          = true
  web_portal_docdb_availability_zones              = formatlist("%s%s", var.region, data.terraform_remote_state.network.outputs.availability_zones)
  web_portal_docdb_enabled_cloudwatch_logs_exports = ["audit"]
  web_portal_docdb_kms_key_id                      = null
  web_portal_docdb_storage_encrypted               = false
  web_portal_docdb_port                            = 27017
  web_portal_docdb_engine                          = "docdb"

  #DocumentDB Cluster instances
  web_portal_docdb_auto_minor_version_upgrade    = false
  web_portal_docdb_promotion_tier                = 0
  web_portal_docdb_instance_availability_zone    = ""

  #DocumentDB cluster subnet group
  web_portal_docdb_subnet_group_description = "Managed by Terraform"

  #DocumentDB cluster parameters group
  web_portal_docdb_parameter_group_description = "Managed by Terraform"
  web_portal_docdb_parameter_group_parameters  = [ {
    apply_method = "pending-reboot"
    name         = "tls"
    value        = "disabled"
  },
  ]
  web_portal_docdb_parameter_group_family      = "docdb3.6"
}