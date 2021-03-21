###############################################
# Provider to connect to AWS
#
# https://www.terraform.io/docs/providers/aws/
###############################################
provider "aws" {
  version = "~> 2.68.0"
  region  = var.region
}

terraform {
  required_version = ">= 0.12"
  backend "s3" {
    key     = "ue1/lupho/application/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = var.bucket
    key    = "env:/${terraform.workspace}/ue1/lupho/network/terraform.tfstate"
    region = "us-east-1"
  }
}
