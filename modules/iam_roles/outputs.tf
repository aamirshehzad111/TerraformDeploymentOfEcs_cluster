output "iam_service_role" {
  value = "${aws_iam_role.ecs-service-roles.name}"
}

output "ec2_instance_role" {
  value = "${aws_iam_instance_profile.ecs-instance-profile1.id}"
}