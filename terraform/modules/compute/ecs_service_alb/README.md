## Purpose

1. The generation of Application load balancer resource
2. The generation of Target groups
3. Attachement of Target groups to ALB
4. Generation of ALB listeners

## Usage example

```
module "example_alb" {
  source = "../../modules/compute/alb"

  lb_security_groups             = [sg_id, sg2_id]
  lb_internal                    = true
  lb_subnets                     = [subnet1_id, subnet2_id]
  lb_deletion_protection         = false
  lb_idle_timeout                = 300
  lb_tg_vpc                      = vpcid
  target_groups                  = target_groups_map
  load_balancer_listener         = load_balancer_listeners_map

  #Naming
  naming_oe                    = "orgname"
  naming_project_name          = "projectname"
  naming_environment_name      = "prod"
  naming_ext                   = "example"
  naming_delimiter             = "_"
  naming_additional_attributes = []
  naming_additional_tags       = []
}
```

## Load balancer target groups list of maps example
```
target_groups = [
  {
    port                             = 8080
    protocol                         = "HTTP"
    target_type                      = "instance"
    health_check_enabled             = true
    health_check_healthy_threshold   = 3
    health_check_unhealthy_threshold = 3
    health_check_port                = 8080
    health_check_interval            = 30
    health_check_protocol            = "HTTP"
    health_check_path                = "/login"
    health_check_matcher             = "200"
  }
]
```

## Load balancer listeners list of maps example
```
  target_groups_load_balancer_listeners = [
    {
      load_balancer_listener_port                = 80
      load_balancer_listener_protocol            = "HTTP"
      load_balancer_listener_default_action_type = "forward"
    }
  ]
```

## Load balancer listener's rules object example
```
  target_groups_load_balancer_listener_rule = {
      count = 1
      action_type = "forward",
      http_header_name = {
        "key" = "value"
      }
    }
```


## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| lb\_deletion\_protection | If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. | `bool` | n/a | yes |
| lb\_idle\_timeout | The time in seconds that the connection is allowed to be idle | `number` | n/a | yes |
| lb\_internal | If true, the LB will be internal | `bool` | n/a | yes |
| lb\_security\_groups | A list of security group IDs to assign to the LB | `list(string)` | n/a | yes |
| lb\_subnets | A list of subnet IDs to attach to the LB. Subnets cannot be updated for Load Balancers of type network | `list(string)` | n/a | yes |
| lb\_tg\_vpc | The identifier of the VPC in which to create the target group. Required when target\_type is instance or ip. Does not apply when target\_type is lambda | `string` | n/a | yes |
| load\_balancer\_listener | n/a | <pre>list(object({<br>    load_balancer_listener_port                = number<br>    load_balancer_listener_protocol            = string<br>    load_balancer_listener_default_action_type = string<br>  }))</pre> | n/a | yes |
| load\_balancer\_listener\_rule | n/a | <pre>object({<br>    count            = number<br>    action_type      = string<br>    http_header_name = object({"string":"string"})<br>  })</pre> | n/a | yes |
naming\_additional\_attributes | Additional attributes (e.g. `policy` or `role`) | `list` | n/a | yes |
| naming\_additional\_tags | Additional tags (e.g. `map('BusinessUnit`,`XYZ`) | `map` | n/a | yes |
| naming\_delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | n/a | yes |
| naming\_environment\_name | Environment to deploy resources, e.g. 'prod', 'test', 'dev', or 'shared' | `string` | n/a | yes |
| naming\_ext | extension to the full name, e.g. Sequence or additional name | `string` | n/a | yes |
| naming\_oe | Organisational entity name | `string` | n/a | yes |
| naming\_project\_name | Project name if projects has it's own environment | `string` | n/a | yes |
| target\_groups | n/a | <pre>list(object({<br>    port                             = number<br>    protocol                         = string<br>    target_type                      = string<br>    health_check_enabled             = bool<br>    health_check_healthy_threshold   = number<br>    health_check_unhealthy_threshold = number<br>    health_check_port                = number<br>    health_check_interval            = number<br>    health_check_protocol            = string<br>    health_check_path                = string<br>    health_check_matcher             = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| lb\_arn | n/a |
| lb\_arn\_suffix | n/a |
| lb\_dns\_name | n/a |
| lb\_id | n/a |
| lb\_tg\_id | n/a |
| lb\_zone\_id | n/a |