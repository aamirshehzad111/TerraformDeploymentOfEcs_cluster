output "tg_arn" {
  value = "${aws_alb_target_group.targeting_group.arn}"
}

output "alb_arn" {
  value = "${aws_alb.load_balacner.arn}"
}

output "alb_listener_rule" {
  value = "${aws_alb_listener_rule.loadbalancer_listener_rule.id}"
}