variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "AMI ID for Amazon Linux 2"
  type        = string
  default     = "ami-0fa3fe0fa7920f68e"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "myPem"
  type        = string
}

# I had a .pem file to establish ssh communication with ec2 instance
# variable "your_key_path" {
#  description = "Path to your public SSH key directory"
# type        = string
#}
