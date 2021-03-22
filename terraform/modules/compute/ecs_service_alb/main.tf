################################################################
# Load balancer resource
################################################################
module "alb_naming" {
  source      = "../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_alb_role_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = var.naming_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_lb" "load_balancer" {
  name               = module.alb_naming.id
  subnets            = var.lb_subnets
  internal           = var.lb_internal
  load_balancer_type = local.lb_type
  security_groups    = var.lb_security_groups

  enable_deletion_protection = var.lb_deletion_protection

  idle_timeout = var.lb_idle_timeout

  tags = module.alb_naming.tags
}

################################################################
# Load balancer target group
################################################################

module "tg_naming" {
  source      = "../../naming"
  oe          = var.naming_oe
  project     = var.naming_project_name
  environment = var.naming_environment_name
  role        = local.naming_tg_role_name
  ext         = var.naming_ext
  delimiter   = var.naming_delimiter
  attributes  = var.naming_tg_additional_attributes
  tags        = var.naming_additional_tags
}

resource "aws_lb_target_group" "load_balancer_tg" {
  count = length(var.target_groups)

  name        = join(var.naming_delimiter, [module.tg_naming.id, lookup(element(var.target_groups, count.index), "label")])
  port        = lookup(element(var.target_groups, count.index), "port")
  protocol    = lookup(element(var.target_groups, count.index), "protocol")
  vpc_id      = var.lb_tg_vpc
  target_type = lookup(element(var.target_groups, count.index), "target_type")
  tags        = module.tg_naming.tags

  health_check {
    enabled             = lookup(element(var.target_groups, count.index), "health_check_enabled")
    healthy_threshold   = lookup(element(var.target_groups, count.index), "health_check_healthy_threshold")
    unhealthy_threshold = lookup(element(var.target_groups, count.index), "health_check_unhealthy_threshold")
    port                = lookup(element(var.target_groups, count.index), "health_check_port")
    interval            = lookup(element(var.target_groups, count.index), "health_check_interval")
    protocol            = lookup(element(var.target_groups, count.index), "health_check_protocol")
    path                = lookup(element(var.target_groups, count.index), "health_check_path")
    matcher             = lookup(element(var.target_groups, count.index), "health_check_matcher")
  }
}

variable "target_groups" {
  description = ""
  type = list(object({
    port                             = number
    protocol                         = string
    target_type                      = string
    health_check_enabled             = bool
    health_check_healthy_threshold   = number
    health_check_unhealthy_threshold = number
    health_check_port                = number
    health_check_interval            = number
    health_check_protocol            = string
    health_check_path                = string
    health_check_matcher             = string
    label                            = string
  }))
}

variable "load_balancer_listener" {
  description = ""
  type = list(object({
    load_balancer_listener_port                = number
    load_balancer_listener_protocol            = string
    load_balancer_listener_default_action_type = string
  }))
}

variable "load_balancer_listener_rule" {
  description = "Rules for the listener."
}


resource "aws_lb_listener" "lb_listner" {
  count = length(var.load_balancer_listener)

  load_balancer_arn = aws_lb.load_balancer.arn
  port              = lookup(element(var.load_balancer_listener, count.index), "load_balancer_listener_port")
  protocol          = lookup(element(var.load_balancer_listener, count.index), "load_balancer_listener_protocol")
  depends_on        = [aws_lb_target_group.load_balancer_tg]

  default_action {
    type             = lookup(element(var.load_balancer_listener, count.index), "load_balancer_listener_default_action_type")
    target_group_arn = aws_lb_target_group.load_balancer_tg[count.index].arn
   fixed_response {
      content_type = "text/plain"
      message_body = "Not Found from: \n${aws_lb.load_balancer.name}"
      status_code  = "404"
    }
  }

  lifecycle {
    ignore_changes = ["default_action"]
  }
}

resource "aws_alb_listener_rule" "rule" {
  count = var.load_balancer_listener_rule.count
  listener_arn = aws_lb_listener.lb_listner[count.index].arn
  action {
    type = try(var.load_balancer_listener_rule.action_type, {})
    target_group_arn = aws_lb_target_group.load_balancer_tg[count.index].arn
  }

  dynamic "condition" {
    for_each = try(var.load_balancer_listener_rule.http_header_name, {})
    iterator = iter
    content {
      http_header {
        http_header_name = iter.key
        values           = [iter.value]
      }
    }
  }
  // Define any other types of the condition.
  dynamic "condition" {
    for_each = try(var.load_balancer_listener_rule.http_request_method, {})
    iterator = iter
    content {
      http_request_method {
        values = [iter.value]
      }
    }
  }

  lifecycle {
    ignore_changes = ["action"]
  }
}