terraform {
  required_version = ">= 0.12.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

variable "region" {}
variable "aws_id" {}
variable "key" {}
variable "aws_sg" {}

provider "aws" {
  region = var.region
}

data "aws_ami" "amzl2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["test-amzn2-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = [var.aws_id]
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amzl2.id
  instance_type          = "t2.micro"
  key_name               = var.key
  vpc_security_group_ids = [var.aws_sg]

	user_data = <<EOF
		#! /bin/bash
    ansible-playbook /tmp/ansible-playbooks/001-nginx.yml
	EOF

  tags = {
    Name = "ayylmao-01"
  }
}