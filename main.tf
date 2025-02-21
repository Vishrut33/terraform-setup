# Define the AWS Provider
provider "aws" {
  region = "ap-south-1"  # Change this to your AWS region (e.g., Mumbai)
}

# Create a Security Group
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow inbound traffic"

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

# Create an EC2 Instance
resource "aws_instance" "web_server" {
  ami                    = "ami-0ddfba243cbee3768"  # Change this to the correct AMI ID for your region
  instance_type          = "t2.micro"
  key_name               = "Terraform"  # Replace with your actual AWS SSH Key Name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "Terraform-Web-Server"
  }
}

