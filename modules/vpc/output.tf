output "public-subnet-1" {
  value = aws_subnet.main["test_1"].id
}

output "public-subnet-2" {
  value = aws_subnet.main["test_2"].id
}

output "private-subnet-1" {
  value = aws_subnet.main["test_1"].id
}

output "private-subnet-2" {
  value = aws_subnet.main["test_2"].id
}