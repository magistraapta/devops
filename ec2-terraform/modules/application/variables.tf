variable "vpc_id" {}
variable "subnet_id" {}

variable "ami_id" {}
variable "instance_type" {
  default = "t2.micro"
}

variable "key_pair_name" {}
