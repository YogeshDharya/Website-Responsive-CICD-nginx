provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "deployer_key" {
  key_name   = "enter key pair"  #This is where I kept my key pair name
  public_key = "/path/2/your-key.pub"  #Directory where my .pem file existed 
}

resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg-"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data     = file("${path.module}/user_data.sh")

  tags = {
    Name = "webserver-terraform"
  }
}

output "instance_public_ip" {
  value = aws_instance.web_instance.public_ip
}
