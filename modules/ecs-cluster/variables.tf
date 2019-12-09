variable "key_name" {
  type        = "string"
  description = "Enter KeyName for SSH"
}

variable "cluster_name" {
  type        = "string"
  description = "Enter cluster name"
}

variable "instance_type_param" {
  type        = "string"
  description = "like t2.micro || t2.medium.. etc"
}


variable "vpc_id" {}
variable "subnets_id" {
  type = "list"
}
variable "df_sg" {}
variable "ec2_instance_role" {}