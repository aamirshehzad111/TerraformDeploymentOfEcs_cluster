variable "vpc_name" {
  type        = "string"
  default     = "vpc_tf"
  description = "Name of the vpc"
}


variable "aws_vpc_cidr_block" {
  type        = "string"
  default     = "10.0.0.0/16"
  description = "vpc cidr block"

}