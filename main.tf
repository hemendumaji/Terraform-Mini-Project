provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

# Create a new public subnet within the VPC
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a" # Change to your preferred availability zone
  map_public_ip_on_launch = true
}

# Create a new security group within the VPC
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.example.id

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

# Create an EC2 instance in the public subnet
resource "aws_instance" "web" {
  ami                  = "ami-0522ab6e1ddcc7055"
  instance_type        = "t2.micro"
  subnet_id            = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "New_assignment"  # updated key pair name

  tags = {
    Name = "example-instance"
  }
}
