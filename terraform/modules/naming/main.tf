locals {
  region_map = {
    "us-east-1"      = "ue1"
    "us-east-2"      = "ue2"
    "us-west-1"      = "uw1"
    "us-west-2"      = "uw2"
    "ca-central-1"   = "cc1"
    "ca-central-2"   = "cc2"
    "eu-west-1"      = "ew1"
    "eu-west-2"      = "ew2"
    "eu-west-3"      = "ew3"
    "eu-central-1"   = "ec1"
    "ap-northeast-1" = "an1"
    "ap-northeast-2" = "an2"
    "ap-southeast-1" = "ase1"
    "ap-southeast-2" = "ase2"
    "ap-south-1"     = "as1"
    "sa-east-1"      = "se1"
  }

  region_short = lookup(local.region_map, data.aws_region.current.name)
}

data "aws_region" "current" {
}

locals {
  id        = lower(join(var.delimiter, compact(concat(list(var.oe, var.project, local.region_short, var.environment, var.role, var.ext), var.attributes))))
  id_length = length(local.id) > 32 ? 32 : length(local.id)
}


resource "null_resource" "default" {

  triggers = {
    id = local.id
  }

  lifecycle {
    create_before_destroy = true
  }
}
