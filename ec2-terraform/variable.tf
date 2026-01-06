variable "aws_regions" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}


variable "availability_zone" {
  type    = string
  default = "ap-southeast-1a"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance. If not provided, latest Amazon Linux 2 AMI will be used."
  type        = string
  default     = null
}
variable "key_pair_name" {}
