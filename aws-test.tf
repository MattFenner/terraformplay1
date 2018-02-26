variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "terraform_test" {
    instance_type = "t2.micro"
    ami           = "${data.aws_ami.ubuntu.id}"

    tags {
        Name = "mf Terraform Enterprise test"
    }
}