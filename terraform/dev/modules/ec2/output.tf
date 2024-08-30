output "instance_ids" {
  value = aws_instance.nency_app[*].id
}
