variable "asg" {
  description = "value"
}

variable "subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = list(string)
}

variable "aws_alb_arn" {
  type = list(string)
}