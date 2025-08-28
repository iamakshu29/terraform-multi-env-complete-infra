# data "aws_vpc" "test" {
#   filter {
#     name   = "tag:Name"
#     values = ["test-vpc"]
#   }
# }
# data "aws_subnet" "test" {
#   filter {
#     name   = "tag:Name"
#     values = ["test-subnet-2"]
#   }
# }

# data "aws_vpc" "dev" {
#   filter {
#     name   = "tag:Name"
#     values = ["dev-vpc"]
#   }
# }
# data "aws_subnet" "dev" {
#   filter {
#     name   = "tag:Name"
#     values = ["dev-subnet-2"]
#   }
# }

# data "aws_vpc" "prod" {
#   filter {
#     name   = "tag:Name"
#     values = ["prod-vpc"]
#   }
# }
# data "aws_subnet" "prod" {
#   filter {
#     name   = "tag:Name"
#     values = ["prod-subnet-2"]
#   }
# }
