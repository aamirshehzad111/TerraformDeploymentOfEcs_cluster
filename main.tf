provider "aws" {

  region = "us-east-1"
}





module "vpc" {
  source = "./modules/virtual_private_network"
}

module "ecs_cluster" {
  source = "./modules/ecs-cluster"
  subnets_id = [

    "${module.vpc.subnet1}",
    "${module.vpc.subnet2}"

  ]
  vpc_id = "${module.vpc.vpc_id}"
  df_sg = "${module.vpc.vpc_default_sgID}"
  cluster_name = "${var.cluster_name}"
  instance_type_param = "${var.instance_type_param}"
  key_name =  "${var.key_name}"
  ec2_instance_role = "${module.iam_roles.ec2_instance_role}"

}

module "iam_roles" {
  source = "./modules/iam_roles"
}

module "ecs_task_definition" {
  source = "./modules/task_definition"
  image_url = "${var.image_url}"

}


module "service_of_app" {
  source = "./modules/service"
  cluster_name = "${module.ecs_cluster.cluster_id}"
  task_def_name = "${module.ecs_task_definition.task_definition_name}"
  task_def_rev = "${module.ecs_task_definition.task_defintion_revision}"
  data_task_def_rev = "${module.ecs_task_definition.data_task_defintion_revision}"
  tg_arn = "${module.alb_for_task.tg_arn}"
  alb_listener_rule = "${module.alb_for_task.alb_listener_rule}"
  iam_service_role = "${module.iam_roles.iam_service_role}"
}

module "alb_for_task" {
  source = "./modules/application_loadbalancer"
  subnets_id = [
    "${module.vpc.subnet1}",
    "${module.vpc.subnet2}"
  ]
  vpc_id = "${module.vpc.vpc_id}"
  alb_sg = "${module.vpc.sg_id}"
  target-group_name = "${var.target-group_name}"
}












