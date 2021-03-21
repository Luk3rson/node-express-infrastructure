# Description: Outputs for ALB

output "lb_dns_name" {
  value = "${element(concat(aws_lb.load_balancer.*.dns_name, list("")), 0)}"
}

output "lb_id" {
  value = "${element(concat(aws_lb.load_balancer.*.id, list("")), 0)}"
}

output "lb_name" {
  value = "${element(concat(aws_lb.load_balancer.*.name, list("")), 0)}"
}


output "lb_zone_id" {
  value = "${element(concat(aws_lb.load_balancer.*.zone_id, list("")), 0)}"
}

output "lb_tg_id" {
  value = "${element(concat(aws_lb_target_group.load_balancer_tg.*.id, list("")), 0)}"
}

output "lb_arn" {
  value = "${element(concat(aws_lb.load_balancer.*.arn, list("")), 0)}"
}

output "lb_arn_suffix" {
  value = "${element(split("/", element(concat(aws_lb.load_balancer.*.arn_suffix, list("")), 0)), 1)}"
}

output "tg_names" {
  value = aws_lb_target_group.load_balancer_tg.*.name
}

output "lb_listener_arns" {
  value = aws_lb_listener.lb_listner.*.arn
}