resource "aws_ecs_service" "app-svc" {
  name = "app-svc"
  depends_on = [var.alb_listener_rule]
  cluster = "${var.cluster_name}"
  task_definition = "${var.task_def_name}:${max("${var.task_def_rev}", "${var.data_task_def_rev}")}"
  desired_count = 2
  launch_type = "EC2"
  iam_role = "${var.iam_service_role}"
  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  health_check_grace_period_seconds = 60
  load_balancer {
    container_name = "php-apache"
    container_port = 80
    target_group_arn = "${var.tg_arn}"
  }
}
