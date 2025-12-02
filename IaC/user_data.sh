#!/bin/bash
# Update and install Docker
sudo yum update -y
sudo yum install docker -y

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Add ec2-user to docker group
sudo usermod -aG docker ec2-user

# Run a test container (optional)
sudo docker run -d -p 80:80 nginx
