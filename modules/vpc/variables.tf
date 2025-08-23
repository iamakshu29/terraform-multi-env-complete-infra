# variable "vpc" {
#   description = "value"
#   default     = {}
# }

variable "vpc" {
  description = "value"
  default = {
    test = {
      cidr_block = "10.1.0.0/16"
      tags = {
        Name = "test-vpc"
      }
    },
    dev = {
      cidr_block = "10.0.0.0/16"
      tags = {
        Name = "dev-vpc"
      }
    },
    prod = {
      cidr_block = "10.2.0.0/16"
      tags = {
        Name = "prod-vpc"
      }
    }
  }
}


variable "subnet" {
  description = "value"
  default     = {}
}

variable "igw" {
  description = "value"
  default     = {}
}

variable "nat-gateway" {
  description = "value"
  default     = {}
}

variable "route-table" {
  description = "value"
  default     = {}
}

variable "vpc-peering" {
  description = "value"
  default     = {}
}
