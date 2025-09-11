variable "rds" {
  description = "value"
}

variable "subnet_ids" {
  type = list(string)
}

variable "kms_key_id" {
  type = string
}