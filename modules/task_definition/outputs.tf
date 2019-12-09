output "task_definition_name" {
  value = "${aws_ecs_task_definition.task_defintion_php.family}"
}

output "task_defintion_revision" {
  value = "${aws_ecs_task_definition.task_defintion_php.revision}"
}

output "data_task_defintion_revision" {
  value = "${data.aws_ecs_task_definition.task_defintion_php.revision}"
}

//output "container_name" {
//  value = "${aws_ecs_task_definition.task_defintion_php.container_definitions}"
//}