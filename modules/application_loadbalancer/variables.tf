variable "target-group_name" {
  type = "string"
  description = "please enter target group name"
}

variable "subnets_id" {
  type = "list"
}

variable "alb_sg" {}
variable "vpc_id" {}