module "vpc" {
  source                         = "../../modules/network/vpc"
  cidr                           = var.vpc_cidr
  instance_tenancy               = local.default_instance_tenancy
  enable_dns_hostnames           = local.enable_vpc_dns
  enable_dns_support             = local.enable_vpc_dns
  enable_classiclink             = local.enable_classic_link
  enable_ipv6                    = local.enable_ipv6
  enable_classiclink_dns_support = local.enable_classic_link
  create_igw                     = var.create_igw

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_ext                   = local.naming_ext
  naming_delimiter             = local.naming_delimiter
  naming_additional_attributes = local.naming_additional_attributes
  naming_additional_tags       = local.naming_additional_tags
}

module "public_subnet" {
  source   = "../../modules/network/subnet"
  vpc_id   = module.vpc.vpc_id
  region   = var.region
  subnet   = var.public_subnet
  azs      = var.azs
  igw_id   = module.vpc.igw_id
  natgw_ids = ""

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_delimiter             = local.naming_delimiter
  naming_additional_attributes = local.naming_additional_attributes
  naming_additional_tags       = local.naming_additional_tags
}

module "jenkins_subnet" {
  source   = "../../modules/network/subnet"
  vpc_id   = module.vpc.vpc_id
  region   = var.region
  subnet   = var.jenkins_subnet
  azs      = var.azs
  igw_id   = ""
  natgw_ids = [module.natgw.natgw_id]

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_delimiter             = local.naming_delimiter
  naming_additional_attributes = local.naming_additional_attributes
  naming_additional_tags       = local.naming_additional_tags
}

module "database_subnet" {
  source   = "../../modules/network/subnet"
  vpc_id   = module.vpc.vpc_id
  region   = var.region
  subnet   = var.database_subnet
  azs      = var.azs
  igw_id   = ""
  natgw_ids = ""

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_delimiter             = local.naming_delimiter
  naming_additional_attributes = local.naming_additional_attributes
  naming_additional_tags       = local.naming_additional_tags
}

module "application_subnet" {
  source   = "../../modules/network/subnet"
  vpc_id   = module.vpc.vpc_id
  region   = var.region
  subnet   = var.application_subnet
  azs      = var.azs
  igw_id   = ""
  natgw_ids = [module.natgw.natgw_id]

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_delimiter             = local.naming_delimiter
  naming_additional_attributes = local.naming_additional_attributes
  naming_additional_tags       = local.naming_additional_tags
}


module "natgw" {
  source     = "../../modules/network/natgw"
  nat_subnet = module.public_subnet.subnet_id[0]
  eip_vpc    = local.eip_vpc

  #Naming
  naming_oe                    = var.naming_oe
  naming_project_name          = var.naming_project_name
  naming_environment_name      = var.naming_environment_name
  naming_ext                   = local.naming_ext
  naming_delimiter             = local.naming_delimiter
  naming_additional_attributes = local.naming_additional_attributes
  naming_additional_tags       = local.naming_additional_tags
}



