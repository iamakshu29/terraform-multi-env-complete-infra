variable "alb" {
  description = "value"
  default = {}
}

variable "subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}