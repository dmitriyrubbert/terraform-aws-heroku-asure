provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_ubuntu" {
  # count         = "3"
  ami           = "ami-0cc0a36f626a4fdf5"
  instance_type = "t2.micro"
  tags = {
    Name    = "My Ubuntu server"
    Owner   = "Dmitriy Lazarev"
    Project = "Lesson"
  }
}

resource "aws_instance" "my_amazon" {
  ami           = "ami-0d4c3eabb9e72650a"
  instance_type = "t2.micro"
  tags = {
    Name    = "My Amazon server"
    Owner   = "Dmitriy Lazarev"
    Project = "Lesson"
  }
  key_name = "deployer-key"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}
