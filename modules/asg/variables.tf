variable "asg" {
  description = "value"
}

variable "subnets" {
  type = list(string)
}

variable "aws_alb_arn" {
  type = list(string)
}

variable "asg_sg_id" {
  type = list(string)
}