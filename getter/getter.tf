provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key

  region  = "us-east-2"
  # profile = "source"

  assume_role {
    role_arn = "arn:aws:iam::596780849713:role/assume_role_in_destination_account"   #created by the setter.tf
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  tags = {
    Name = "created_from_source_account_using_assume_role!"
  }
}

#This script allows users from the SOURCE account to Assume the role previously created in setter.tf which grants the SOURCE user the ability
#to spin up an EC2 in the DESTINATION account 