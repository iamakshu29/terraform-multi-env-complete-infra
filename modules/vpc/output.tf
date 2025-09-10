output "public_subnet_1" {
  value = aws_subnet.main["test_1"].id
}

output "public_subnet_2" {
  value = aws_subnet.main["test_2"].id
}

output "private_subnet_1" {
  value = aws_subnet.main["test_3"].id
}

output "private_subnet_2" {
  value = aws_subnet.main["test_4"].id
}

output "vpc_id" {
  value = aws_vpc.main.id
}