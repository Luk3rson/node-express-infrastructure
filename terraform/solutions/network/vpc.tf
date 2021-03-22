module "vpc" {
  source = "../../modules/network/vpc"

  # paramters
  cidr                           = var.vpc_cidr
  instance_tenancy               = "default"
  enable_dns_hostnames           = true
  enable_dns_support             = true
  enable_classiclink             = false
  enable_ipv6                    = false
  enable_classiclink_dns_support = false
  create_igw                     = true
  //max_aggregation_interval       = 600

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_ext                   = local.naming_ext
  naming_delimiter             = local.naming_delimiter
  naming_additional_attributes = local.naming_additional_attributes
  naming_additional_tags       = local.naming_additional_tags
}

module "public-subnet" {
  source = "../../modules/network/subnet"

  # paramters
  azs       = var.azs
  igw_id    = module.vpc.igw_id
  natgw_ids = []
  region    = var.region
  subnet    = var.subnets["public"]
  vpc_id    = module.vpc.vpc_id

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_delimiter             = local.naming_delimiter
  naming_additional_attributes = local.naming_additional_attributes
  naming_additional_tags       = local.naming_additional_tags
}

module "natgw-a" {
  source = "../../modules/network/natgw"

  # paramters
  eip_vpc         = true
  nat_subnet      = module.public-subnet.subnet_id[0]
  nat_gtw_enabled = true

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_ext                   = "a"
  naming_delimiter             = local.naming_delimiter
  naming_additional_attributes = local.naming_additional_attributes
  naming_additional_tags       = local.naming_additional_tags
}
/*
module "natgw-b" {
  source = "../../modules/network/natgw"

  # paramters
  eip_vpc                       = true
  nat_subnet                    = module.public-subnet.subnet_id[1]
  nat_gtw_enabled               = var.nat_gtw_enabled

  # naming
  naming_additional_attributes  = local.naming_additional_attributes
  naming_additional_tags        = local.naming_additional_tags
  naming_delimiter              = local.naming_delimiter
  naming_environment_name       = terraform.workspace
  naming_ext                    = "b"
  naming_oe                     = var.naming_oe
}

module "natgw-c" {
  source = "../../modules/network/natgw"

  # paramters
  eip_vpc                       = true
  nat_subnet                    = module.public-subnet.subnet_id[2]
  nat_gtw_enabled               = var.nat_gtw_enabled

  # naming
  naming_additional_attributes  = local.naming_additional_attributes
  naming_additional_tags        = local.naming_additional_tags
  naming_delimiter              = local.naming_delimiter
  naming_environment_name       = terraform.workspace
  naming_ext                    = "c"
  naming_oe                     = var.naming_oe
}*/

module "private-subnet" {
  source = "../../modules/network/subnet"

  # paramters
  natgw_ids = [module.natgw-a.natgw_id]//, module.natgw-b.natgw_id, module.natgw-c.natgw_id]
  region    = var.region
  subnet    = var.subnets["private"]
  vpc_id    = module.vpc.vpc_id
  azs       = var.azs
  igw_id    = ""

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_delimiter             = local.naming_delimiter
  naming_additional_attributes = local.naming_additional_attributes
  naming_additional_tags       = local.naming_additional_tags
}