################################################################################################
# Subnet resource
################################################################################################
module "subnet_naming" {
  count       = length(var.subnet.cidrs)
  source      = "../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_subnet_role_name
  ext         = join(var.naming_delimiter, [lookup(var.subnet, "subnet_type"), var.azs[count.index]])
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

  tags = module.subnet_naming[count.index].tags
}

################################################################################################
# Route table resource
################################################################################################

module "routetable_naming" {
  count = length(var.subnet.cidrs)
  source = "../../naming"
  oe     = var.naming_oe
  project = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_rt_role_name
  ext         = join(var.naming_delimiter, [lookup(var.subnet, "subnet_type"), var.azs[count.index]])
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_route_table" "this" {
  count  = length(var.subnet.cidrs)
  vpc_id = var.vpc_id
  tags   = module.routetable_naming[count.index].tags
}

resource "aws_route_table_association" "route_table_subnet_assocs" {
  count          = length(var.subnet.cidrs)
  subnet_id      = aws_subnet.this[count.index].id
  route_table_id = aws_route_table.this[count.index].id
}

################################################################################################
# Route table route - internet gateway
################################################################################################

resource "aws_route" "igw" {
  count                  = var.subnet.subnet_type == "public" ? length(var.subnet.cidrs) : 0
  route_table_id         = aws_route_table.this[count.index].id
  destination_cidr_block = lookup(var.subnet, "igw_destination_cidr")
  gateway_id             = var.igw_id
}

################################################################################################
# Route table route - nat gateway
################################################################################################

resource "aws_route" "natgw_prod" {
  count                  = var.subnet.subnet_type == "private" && terraform.workspace == "prod" ? length(var.natgw_ids) : 0
  route_table_id         = aws_route_table.this[count.index].id
  destination_cidr_block = lookup(var.subnet, "natgw_destination_cidr")
  nat_gateway_id         = var.natgw_ids[count.index]
}

resource "aws_route" "natgw_non_prod" {
  count                  = var.subnet.subnet_type == "private" && terraform.workspace != "prod" ? length(var.subnet.cidrs) : 0
  route_table_id         = aws_route_table.this[count.index].id
  destination_cidr_block = lookup(var.subnet, "natgw_destination_cidr")
  nat_gateway_id         = var.natgw_ids[0]
}

################################################################################################
# NACL resource
################################################################################################
module "nacl_naming" {
  source = "../../naming"
  oe     = var.naming_oe
  project = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_nacl_role_name
  ext         = lookup(var.subnet, "subnet_type")
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_network_acl" "this" {
  count  = length(var.subnet.nacl_rules) > 0 ? 1 : 0
  vpc_id = var.vpc_id
  tags   = module.nacl_naming.tags
}

resource "aws_network_acl_rule" "nacl_rule" {
  for_each       = var.subnet.nacl_rules
  network_acl_id = aws_network_acl.this[0].id

  rule_number = each.value.rule_no
  egress      = each.value.egress
  protocol    = each.value.protocol
  rule_action = each.value.action
  cidr_block  = each.value.cidr_block
  from_port   = each.value.from_port
  to_port     = each.value.to_port
}