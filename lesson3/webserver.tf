# https://awsregion.info

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-0d4c3eabb9e72650a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  tags = {
    Name    = "My Ubuntu server"
    Owner   = "Dmitriy Lazarev"
    Project = "Lesson"
  }
  user_data = file("userdata.sh")
}

resource "aws_security_group" "my_webserver" {
  name        = "my_webserver"
  description = "Allow HTTP inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
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
