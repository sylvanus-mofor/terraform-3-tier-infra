variable "private_subnet1" {
  description = "private subnet 1 id"
  type = string
}

variable "private_subnet2" {
  description = "private subnet 2 id"
  type = string
}

variable "tags" {
  description = "tags"
  type = map(string)
}

variable "vpc_id" {
  description = "vpc-id"
  type = string
}

variable "vpc_cidr" {
  description = "vpc cidr range"
  type = string
}