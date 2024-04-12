provider "aws" {
  region     = "e.g. us-east-1"
  access_key = "PUT-YOUR-ACCESS-KEY-HERE"
  secret_key = "PUT-YOUR-SECRET-KEY-HERE"
}

resource "aws_instance" "myec2" {
    ami = "ami-ID"
    instance_type = "e.g. t2.micro"
}


