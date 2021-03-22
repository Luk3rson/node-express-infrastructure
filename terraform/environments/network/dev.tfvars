region     = "us-east-1"
bucket  = "web-app-terraform-state-dev"
vpc_cidr = "172.18.0.0/16"
create_igw = true

#Naming
naming_oe               = "lupho"
naming_project_name     = "web"
naming_environment_name = "dev"
// TODO subnets need to match azs otherwise output cannot be used for DocDB
azs = ["a", "b", "c"]

subnets = {
  public = {
    cidrs                   = ["172.18.0.0/20", "172.18.16.0/20", "172.18.32.0/20"]
    subnet_type             = "public"
    map_public_ip_on_launch = false
    natgw_destination_cidr  = ""
    igw_destination_cidr    = "0.0.0.0/0"
    nacl_rules              = {}
  }
  private = {
    cidrs                   = ["172.18.64.0/19", "172.18.96.0/19", "172.18.128.0/19"]
    subnet_type             = "private"
    map_public_ip_on_launch = false
    natgw_destination_cidr  = "0.0.0.0/0"
    igw_destination_cidr    = ""
    nacl_rules              = {}
  }
}

# private subnet -  172.18.64.0/19
# public subnet  -  172.18.0.0/20

# private subnet -  172.18.96.0/19
# public subnet  -  172.18.16.0/20

# private subnet -  172.18.128.0/19
# public subnet  -  172.18.32.0/20
