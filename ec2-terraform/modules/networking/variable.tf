variable "vpc_cidr" {
  description = "vpc cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet" {
  description = "public subnet cidr block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {}
