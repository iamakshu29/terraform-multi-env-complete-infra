variable "env" {
  description = "Which Env is using by us"
  default = ""  
}

variable "kms" {
  description = "value"
  default     = {}
}

variable "asg" {
  description = "value"
  default     = {}
}

variable "alb" {
  description = "value"
  default     = {}
}

variable "s3" {
  description = "value"
  default     = {}
}

variable "ec2" {
  description = "value"
  default     = {}
}

variable "vpc" {
  description = "value"
  default     = {}
}

variable "subnet" {
  description = "value"
  default     = {}
}

variable "internet_gateway" {
  description = "value"
  default     = {}
}

variable "nat_gateway" {
  description = "value"
  default     = {}
}

variable "route_table" {
  description = "value"
  default     = {}
}

variable "use_igw" {
  description = "Boolean value"
  # default = Boolean 
}

variable "use_nat" {
  description = "Boolean value"
  # default = Boolean 
}

variable "vpc_peering" {
  description = "value"
  default     = {}
}


variable "rds" {
  description = "value"
  default     = {}
}

variable "secrets_manager" {
  description = "value"
  default     = {}
}
