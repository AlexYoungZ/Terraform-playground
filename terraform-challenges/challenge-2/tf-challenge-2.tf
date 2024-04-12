terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "security_group_payment_app" {
  name        = "payment_app"
  description = "Application Security Group"
  depends_on  = [aws_eip.example]

  ingress {
    description = "ingress allows HTTPS  from DEV VPC"
    from_port   = var.https
    to_port     = var.https
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }


  ingress {
    description = "ingress allows APIs access from DEV VPC"
    from_port   = var.dev_vpc
    to_port     = var.dev_vpc
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }


  ingress {
    description = "ingress allows APIs access from Prod App Public IP."
    from_port   = var.prod_apis
    to_port     = var.prod_apis
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.example.public_ip}/32"]
  }
  egress {
    from_port   = var.splunk
    to_port     = var.splunk
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "example" {
  domain = "vpc"
}