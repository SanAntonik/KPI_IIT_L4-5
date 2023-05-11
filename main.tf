terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-north-1"
  # access_key = "${var.AWS_ACCESS_KEY_ID}"
  # secret_key = "${var.AWS_SECRET_ACCESS_KEY}"
  # access_key  = var.AWS_ACCESS_KEY_ID
  # secret_key  = var.AWS_SECRET_ACCESS_KEY
#   access_key  = env("AWS_ACCESS_KEY_ID")
#   secret_key  = env("AWS_SECRET_ACCESS_KEY")
}

resource "aws_instance" "lab6instance" {
  ami                    = "ami-064087b8d355e9051"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.terra_sg.id]
  key_name               = "lab4key"
  tags = {
    Name = "lab6instance"
  }
}

resource "aws_security_group" "terra_sg" {
  name        = "security group using Terraform"
  description = "security group using Terraform"
  vpc_id      = "vpc-02d9d7a16d929d812"

  ingress {
    description = "Allow Inbound HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Inbound HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
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
    Name = "terra_sg"
  }
}
