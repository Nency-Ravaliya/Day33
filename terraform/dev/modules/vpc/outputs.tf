output "vpc_id" {
  value = aws_vpc.nency_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.nency_public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.nency_private[*].id
}
