output "vpc_id" {
  value = "${aws_vpc.environment_example_two.id}"
}

output "sg_id" {
  value = "${aws_security_group.public_subnet_SG.id}"
}

output "subnet1" {
  value = "${aws_subnet.public_subnet.id}"
}

output "subnet2" {
  value = "${aws_subnet.public_subnet_01.id}"
}

output "vpc_default_sgID" {
  value = "${aws_vpc.environment_example_two.default_security_group_id}"
}