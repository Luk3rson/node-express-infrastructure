region     = "us-east-1"
bucket  = "web-app-terraform-state-prod"
vpc_cidr   = "10.0.0.0/16"
create_igw = true

#Naming
naming_oe               = "lupho"
naming_project_name     = "web"
naming_environment_name = "prod"
// TODO subnets need to match azs otherwise output cannot be used for DocDB
azs = ["a", "b"]

public_subnet = {
  cidrs                   = ["10.0.0.0/21", "10.0.8.0/21"]
  subnet_type             = "public"
  map_public_ip_on_launch = true
  natgw_destination_cidr  = ""
  igw_destination_cidr    = "0.0.0.0/0"
}

jenkins_subnet = {
  cidrs                   = ["10.0.16.0/21", "10.0.24.0/21"]
  subnet_type             = "jenkins"
  map_public_ip_on_launch = false
  natgw_destination_cidr  = "0.0.0.0/0"
  igw_destination_cidr    = ""
}

database_subnet = {
  cidrs                   = ["10.0.32.0/21", "10.0.40.0/21"]
  subnet_type             = "database"
  map_public_ip_on_launch = false
  natgw_destination_cidr  = ""
  igw_destination_cidr    = ""
}

application_subnet = {
  cidrs                   = ["10.0.48.0/21", "10.0.56.0/21"]
  subnet_type             = "application"
  map_public_ip_on_launch = false
  natgw_destination_cidr  = "0.0.0.0/0"
  igw_destination_cidr    = ""
}
