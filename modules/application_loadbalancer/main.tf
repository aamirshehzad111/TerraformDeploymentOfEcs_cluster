resource "aws_alb" "load_balacner" {
  subnets = "${var.subnets_id}"
  security_groups = ["${var.alb_sg}"]
  tags = {
    Name = "ALB"
  }
}

resource "aws_alb_target_group" "targeting_group" {
  name = "${var.target-group_name}"
  health_check {
    interval = 6
    protocol = "HTTP"
    path = "/"
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2

  }
  port = 80
  protocol = "HTTP"
  vpc_id = "${var.vpc_id}"

}

resource "aws_alb_listener" "loadbalancer_listener" {
  load_balancer_arn = "${aws_alb.load_balacner.arn}"
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.targeting_group.arn}"
  }
}

resource "aws_alb_listener_rule" "loadbalancer_listener_rule" {
  listener_arn = "${aws_alb_listener.loadbalancer_listener.arn}"
  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.targeting_group.arn}"
  }
  condition {
    field = "path-pattern"
    values = ["*"]
  }
  priority = 1
}