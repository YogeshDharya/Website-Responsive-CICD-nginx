resource "aws_security_group" "ssh_access" {
  name = "${var.environment}-ssh-access"
  description = "Security group for SSH access for the ${var.environment} environment"
   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
    description = "SSH access from my IP"
    }
   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["122.181.103.20/32"]
    description = "HTTP access from my IP"
    }
   egress{
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
  tags = {
    Name        = "${var.environment}-ssh-access-sg"
    Environment = var.environment
  }
}