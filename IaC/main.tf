provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "deployer_key" {
  key_name   = var.key_name 
  public_key = file(var.key_path)
}

# resource "aws_vpc" "assignment_vpc"{
#   cidr_block = "10.0.0.0/16"
#   enable_dns_hostnames = true
#   tags = {
#     Name = "Null Class VPC"
#   }
# }

# resource "aws_internet_gateway" "assignment_igw" {
#   vpc_id = aws_vpc.assignment_vpc.id
#   tags = {Name="Assignment IGW"}
# }

# resource "aws_subnet" "public_subnet" {
#   vpc_id = aws_vpc.assignment_vpc.id
#   cidr_block = "10.0.1.0/24"
#   map_public_ip_on_launch = true
#   availability_zone = "${var.aws_region}a"
#   tags = {
#     Name = "Assignment Public Subnet"
#   }
# }

# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.assignment_vpc.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }
# }

# resource "aws_route_table_association" "public_assoc" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_rt.id
# }

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
  owners = var.ami_owners
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
