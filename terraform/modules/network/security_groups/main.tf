######################################################
# Security group resource
######################################################
module "sg_naming" {
  source      = "../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_sg_role_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}
resource "aws_security_group" "secgroup" {
  name        = module.sg_naming.id
  vpc_id      = var.vpcid
  description = var.sgdescription
  tags        = module.sg_naming.tags
}

######################################################
# Ingress rules when source is cidr
######################################################
resource "aws_security_group_rule" "in_src_cidr" {
  type              = "ingress"
  protocol          = lookup(var.sg_in_cidr_rules[count.index], "protocol", "tcp")
  cidr_blocks       = split(",", lookup(var.sg_in_cidr_rules[count.index], "cidr_blocks"))
  security_group_id = aws_security_group.secgroup.id
  from_port         = lookup(var.sg_in_cidr_rules[count.index], "from_port")
  to_port           = lookup(var.sg_in_cidr_rules[count.index], "to_port")
  description       = lookup(var.sg_in_cidr_rules[count.index], "description", "SG rule managed by terraform")
  self              = lookup(var.sg_in_cidr_rules[count.index], "self", "false")
  count             = length(var.sg_in_cidr_rules)
}

######################################################
# Egress rules when source is cidr
######################################################
resource "aws_security_group_rule" "eg_src_cidr" {
  type              = "egress"
  protocol          = lookup(var.sg_eg_cidr_rules[count.index], "protocol", "tcp")
  cidr_blocks       = split(",", lookup(var.sg_eg_cidr_rules[count.index], "cidr_blocks"))
  security_group_id = aws_security_group.secgroup.id
  from_port         = lookup(var.sg_eg_cidr_rules[count.index], "from_port")
  to_port           = lookup(var.sg_eg_cidr_rules[count.index], "to_port")
  description       = lookup(var.sg_eg_cidr_rules[count.index], "description", "SG rule managed by terraform")
  self              = lookup(var.sg_eg_cidr_rules[count.index], "self", "false")
  count             = length(var.sg_eg_cidr_rules)
}

######################################################
# Ingress rules when source is security group
######################################################
resource "aws_security_group_rule" "in_src_sgsrc" {
  type                     = "ingress"
  protocol                 = lookup(var.sg_in_sgsrc_rules[count.index], "protocol", "tcp")
  source_security_group_id = lookup(var.sg_in_sgsrc_rules[count.index], "src_sg_id")
  security_group_id        = aws_security_group.secgroup.id
  from_port                = lookup(var.sg_in_sgsrc_rules[count.index], "from_port")
  to_port                  = lookup(var.sg_in_sgsrc_rules[count.index], "to_port")
  description              = lookup(var.sg_in_sgsrc_rules[count.index], "description", "SG rule managed by terraform")
  count                    = var.sg_insrc_count
}

######################################################
# Egress rules when source is security group
######################################################
resource "aws_security_group_rule" "eg_src_sgsrc" {
  type                     = "egress"
  protocol                 = lookup(var.sg_eg_sgsrc_rules[count.index], "protocol", "tcp")
  source_security_group_id = lookup(var.sg_eg_sgsrc_rules[count.index], "src_sg_id")
  security_group_id        = aws_security_group.secgroup.id
  from_port                = lookup(var.sg_eg_sgsrc_rules[count.index], "from_port")
  to_port                  = lookup(var.sg_eg_sgsrc_rules[count.index], "to_port")
  description              = lookup(var.sg_eg_sgsrc_rules[count.index], "description", "SG rule managed by terraform")
  count                    = length(var.sg_eg_sgsrc_rules)
}


/*
Examples
  // Ingress rules from CIDR
  sg_in_cidr_rules = [
    {
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      from_port   = "0"
      to_port     = "65535"
      description = "All TCP inbound"
    },
    {
      protocol    = "udp"
      cidr_blocks = "0.0.0.0/0"
      from_port   = "0"
      to_port     = "65535"
      description = "All UDP inbound"
    },
  ]
  // Egress rules from CIDR
  sg_eg_cidr_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}




*/
