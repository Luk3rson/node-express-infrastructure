################################################################
# Load balancer variables
################################################################

variable "lb_security_groups" {
  type        = list(string)
  description = "A list of security group IDs to assign to the LB"
}

variable "lb_internal" {
  type        = bool
  description = "If true, the LB will be internal"
}

variable "lb_subnets" {
  type        = list(string)
  description = "A list of subnet IDs to attach to the LB. Subnets cannot be updated for Load Balancers of type network"
}

variable "lb_deletion_protection" {
  type        = bool
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer."
}

variable "lb_idle_timeout" {
  type        = number
  description = "The time in seconds that the connection is allowed to be idle"
}

################################################################
# Target group variables 
################################################################
variable "lb_tg_vpc" {
  type        = string
  description = "The identifier of the VPC in which to create the target group. Required when target_type is instance or ip. Does not apply when target_type is lambda"
}

################################################################
# Load balancer health check variables
################################################################



################################################################
# Load balancer listener
################################################################
# variable "lb_listner_protocol" {
#   type        = string
#   description = "The protocol for connections from clients to the load balancer. Valid values are TCP, TLS, UDP, TCP_UDP, HTTP and HTTPS"
# }

# variable "lb_listner_port" {
#   type        = number
#   description = "The port on which the load balancer is listening."
# }

# variable "lb_listner_default_action_type" {
#   type        = string
#   description = "The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc."
# }
