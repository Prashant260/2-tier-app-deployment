output "frontend_ip_dev" {
  value = aws_instance.dev_instance.public_ip
}

output "backend_ip_dev" {
  value = aws_instance.dev_instance.private_ip
}

output "frontend_ip_staging" {
  value = aws_instance.staging_instance.public_ip
}

output "backend_ip_staging" {
  value = aws_instance.staging_instance.private_ip
}