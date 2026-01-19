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
# TODO: is this for amazon linux 2 or 2023 ? 
variable "ami_id" {
  description = "Enter your AMI ID for Amazon Linux 2"
  type        = string
  default     = "ami-0fa3fe0fa7920f68e"
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
#TODO: a variable for subnet Id and vpc too
#FIXME: one for instance tag, environment too

variable "environment" {
  description = "Environment Name"
  type = string
}

variable "subnet_id"{
  description = "Subnet Id for Amazon Linux EC2"
  type = string
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
#TODO: Can be removed now
variable "ingress_rules"{
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string) 
    description = string
  }))
  default = []
}

# TODO: Can be removed now
variable "egress_rules"{
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [{
    from_port = 0,
    to_port = 0,
    protocol = "-1",
    cidr_blocks = ["0.0.0.0/0"],
    description = "Allow all outbound"
  }]
}

variable "allowed_ssh_cidr"{
  description = "ssh allowed CIDR blocks"
  type = list(string)
  default = []
}
variable "most_recent"{
  type = bool
  description = "Using the most AMI matching filters"
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

