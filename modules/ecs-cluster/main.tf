resource "aws_ecs_cluster" "ec2_cluster" {
  name = "${var.cluster_name}"
  tags = {
    Name = "${var.cluster_name}"
  }
}


data "aws_ami" "amazon_linux_ecs" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}

resource "aws_launch_configuration" "container_instacne" {
  image_id                    = "${data.aws_ami.amazon_linux_ecs.id}"
  instance_type               = "${var.instance_type_param}"
  iam_instance_profile        = "${var.ec2_instance_role}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${var.df_sg}"]
  lifecycle {
    create_before_destroy = true
  }
  associate_public_ip_address = true
  user_data                   = <<EOF
            #!/bin/bash -xe
            echo ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config
            yum install -y aws-cfn-bootstrap
            EOF
}

resource "aws_autoscaling_group" "ecs_auto_scalling_container1" {
  name                 = "ecs_container_auto_scalling1"
  launch_configuration = "${aws_launch_configuration.container_instacne.name}"
  vpc_zone_identifier = "${var.subnets_id}"
  max_size         = 1
  min_size         = 0
  desired_capacity = 1

}
