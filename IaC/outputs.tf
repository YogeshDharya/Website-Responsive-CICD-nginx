output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.docker_host.public_ip
}

output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.docker_host.id
}

output "security_group_id"{
  description = "Security Group ID"
  value       = aws_security_group.assignment_sg.id
}
