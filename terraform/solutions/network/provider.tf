########################################
# Provider to connect to AWS
#
# https://www.terraform.io/docs/providers/aws/
########################################

terraform {
  required_version = ">= 0.12"
  backend "s3" {
    key     = "ue1/lupho/network/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
provider "aws" {
  version = "~> 2.41.0"
  region  = var.region
}
