#TaskDefintion

//data "aws_ssm_parameter" "mysql_password" {
//  name = ""
//}

data "aws_ecs_task_definition" "task_defintion_php" {
  depends_on = [ "aws_ecs_task_definition.task_defintion_php" ]
  task_definition = "${aws_ecs_task_definition.task_defintion_php.family}"
}

resource "aws_ecs_task_definition" "task_defintion_php" {

  family = "task-terraform-php"

  container_definitions = <<DEFINITION
  [
  {
          "name": "php-apache",
          "image": "${var.image_url}",
          "memoryReservation": 256,
          "portMappings" : [
            {
              "containerPort": 80,
              "hostPort": 0
            }
          ]

  },

  {
          "name":  "mysql-php",
          "image": "mysql:latest",
          "portMappings" : [
            {
              "containerPort": 3306,
              "hostPort": 0
            }
          ],
          "memoryReservation": 256,
          "environment": [
            {
              "name": "MYSQL_ROOT_PASSWORD",
              "value": "pythonDeveloper1122"
            }
          ]
  }
  ]
  DEFINITION

  network_mode = "bridge"
  cpu          = "512"
  memory       = "1024"
}