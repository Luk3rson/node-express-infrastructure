################################################################################################
# Subnet resource
################################################################################################
module "subnet_naming" {
  source      = "../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_subnet_role_name
  ext         = lookup(var.subnet, "subnet_type")
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_subnet" "this" {
  count = length(lookup(var.subnet, "cidrs", 0))

  vpc_id                  = var.vpc_id
  cidr_block              = element(lookup(var.subnet, "cidrs"), count.index)
  availability_zone       = join("", [var.region, element(var.azs, count.index)])
  map_public_ip_on_launch = lookup(var.subnet, "map_public_ip_on_launch")

  tags = module.subnet_naming.tags
}

################################################################################################
# Route table resource
################################################################################################

module "routetable_naming" {
  source      = "../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_rt_role_name
  ext         = lookup(var.subnet, "subnet_type")
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = module.routetable_naming.tags
}

resource "aws_route_table_association" "route_table_subnet_assocs" {
  count          = length(lookup(var.subnet, "cidrs", 0))
  subnet_id      = aws_subnet.this.*.id[count.index]
  route_table_id = aws_route_table.this.id
}

################################################################################################
# Route table route - internet gateway
################################################################################################

resource "aws_route" "igw" {
  count                  = var.igw_id != "" ? 1 : 0
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = lookup(var.subnet, "igw_destination_cidr")
  gateway_id             = var.igw_id
}

################################################################################################
# Route table route - nat gateway
################################################################################################

resource "aws_route" "natgw" {
  count                  = var.natgw_id != "" ? 1 : 0
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = lookup(var.subnet, "natgw_destination_cidr")
  nat_gateway_id         = var.natgw_id
}
