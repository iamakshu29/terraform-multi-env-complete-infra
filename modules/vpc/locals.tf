# locals {
#   selected_vpc_id = lookup({
#     dev  = data.aws_vpc.dev.id,
#     test = data.aws_vpc.test.id,
#     prod = data.aws_vpc.prod.id
#   }, var.env)

#   selected_subnet_id = lookup({
#     dev  = data.aws_subnet.dev.id,
#     test = data.aws_subnet.test.id,
#     prod = data.aws_subnet.prod.id
#   }, var.env)
  
# }