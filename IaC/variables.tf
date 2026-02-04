variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Enter your AMI ID for Amazon Linux 2"
  type        = string
  default     = "ami-0532be01f26a3de55"
}

variable "ami_owners"{
  type = list(string)
  description = "List of AMI owners"
  default = ["amazon"]
}

variable "sg_name"{
  type = string
}

variable "sg_description"{
  type = string
}

variable "tags" {
  description = "Common tags for all resources"
  type = map(string)
  default = {
    "name" = "value"
  }
}

variable "environment" {
  description = "Environment Name"
  type = string
  default = "Development"
}


variable "ami_name_filter" {
  type = string 
  description = "Name filter for Amazon Linux 2023 AMI"
  default = "al2023-ami-*-x86_64"
}

variable "ami_virtualization_filter" {
  type = string
  description = "Virtualization type filter for AMI"
  default = "hvm"
}

variable "allowed_tcp_cidr"{
  description = "Valid CIDR blocks"
  type = list(string)
  default = []
}

variable "most_recent"{
  type = bool
  description = "Using the most recent AMI matching filters"
  default = true
}

variable "key_name" {
  description = "Enter name of your aws key pair"
  type        = string
}

variable "key_path"{
  description = "Local path 🖥️ to your aws key pair"
  type = string
}

