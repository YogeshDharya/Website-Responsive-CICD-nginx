provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "deployer_key" {
  key_name   = var.key_name
  public_key = file(pathexpand(var.key_path))
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default"{
  vpc_id = data.aws_vpc.default.id
  availability_zone = "${var.aws_region}a"
  default_for_az = true
}

resource "aws_security_group" "assignment_sg" {
  name = "${var.environment}-ssh-http-access"
  vpc_id = data.aws_vpc.default.id
  description = "Security group for SSH & HTTP access for the ${var.environment} environment"
   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_tcp_cidr
    description = "SSH access from my IP"
    }
   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_tcp_cidr
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
    Name        = "${var.tags["Environment"]}-ssh-http-access-sg"
    Environment = var.tags.Environment
  }
}

data "aws_ami" "amazon_linux_2023"{
  most_recent = var.most_recent
  owners = ["amazon"]
  filter{
    name = "name"
    values = [var.ami_name_filter]
  }
  filter{
    name = "virtualization-type"
    values = [var.ami_virtualization_filter]
  }
}

resource "aws_instance" "docker_host" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.assignment_sg.id]
  user_data     = file("${path.module}/scripts/user_data.sh")
  tags = {
    Name = "Null Class Web Server"
    Environment = var.tags.Environment
    Project     = var.tags.Project
    ManagedBy   = var.tags.ManagedBy
  }
}
