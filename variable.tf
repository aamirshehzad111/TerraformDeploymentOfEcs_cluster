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

variable "image_url" {
  type = "string"
  description = "Eneter image url please"
}

variable "target-group_name" {
  type = "string"
  description = "please enter target group name"
}