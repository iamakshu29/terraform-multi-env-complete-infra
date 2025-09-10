locals {
  subnet_ids = [
    output.public_subnet_1,
    output.public_subnet_2,
    output.private_subnet_1,
    output.private_subnet_2
  ]
}
