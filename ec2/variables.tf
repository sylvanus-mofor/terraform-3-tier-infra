variable "tags" {
  description = "tags"
  type        = map(string)
}

variable "ami" {
  description = "amazon machine image"
  type        = string
  default     = "ami-05c13eab67c5d8861"
}

variable "instance_type" {
  description = "ec2 instance"
  type        = string
  default = "t2.micro"
}

variable "subnet_id" {
  description = "subnet in which to launch the ec2 instance"
  type        = string
}

variable "vpc_id" {
  description = "vpc-id"
  type = string
}

# variable "vpc_cidr" {
#   description = "vpc cidr range"
#   type = string
# }