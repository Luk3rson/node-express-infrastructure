######################################################
# EIP resource
######################################################
module "eip_naming" {
  source      = "../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_eip_role_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_eip" "nat" {
  vpc  = var.eip_vpc
  tags = module.eip_naming.tags
}

######################################################
# NAT gateway resource
######################################################
module "ngw_naming" {
  source = "../../naming"
  oe     = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_nat_role_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_nat_gateway" "this" {
  count = var.nat_gtw_enabled ? 1 : 0
  allocation_id = aws_eip.nat.id
  subnet_id     = var.nat_subnet
  tags          = module.ngw_naming.tags
}

