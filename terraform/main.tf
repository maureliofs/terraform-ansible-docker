terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "teste" {
  count         = 2
  ami           = "ami-0dba2cb6798deb6d8"
  instance_type = "t2.micro"
  key_name      = "terraform"
  tags          = {
    Name        = "teste${count.index}"
  }
  #vpc_security_group_ids = ["sg-0721448541363768e", "sg-099fbeb8f862b1260", "sg-0f83314592d47c8fc"]
}

resource "aws_security_group" "acesso_ssh" {
  name        = "acesso_ssh"
  description = "Liberando acesso ssh aos servidores"

  ingress {
    from_port   = 22
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

  tags = {
    Name        = "Acesso SSH"
  }
}

resource "aws_security_group" "acesso_http" {
  name        = "acesso_http"
  description = "Liberando acesso http aos servidores"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Acesso HTTP"
  }
}

  resource "aws_security_group" "acesso_mysql" {
  name        = "acesso_mysql"
  description = "Liberando acesso mysql aos servidores"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Acesso MYSQL"
  }
}
