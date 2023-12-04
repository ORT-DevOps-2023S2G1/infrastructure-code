terraform {

    cloud {
      organization = "ORT-DevOps-2023S2G1"

      workspaces {
        name = "github-actions-terraform-aws"
      }
    }

    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
        }
        random = {
          source  = "hashicorp/random"
          version = "3.4.3"
        }
    }

    required_version = ">= 1.6.3"

    # Adding Backend as S3 for Remote State Storage with State Locking
    #backend "s3" {
    #    bucket = "terraform-DevOpsLab"
    #    key    = "dev2/terraform.tfstate"
    #    region = "us-east-1"  

    # For State Locking
    #dynamodb_table = "terraform-dev-state-table"
    #}

}


provider "aws" {
    profile = "default" # AWS Credentials Profile configured on local desktop terminal  $HOME/.aws/credentials
    region  = "us-east-1"
}

resource "random_pet" "sg" {}

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

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              sed -i -e 's/80/8080/' /etc/apache2/ports.conf
              echo "Hello World" > /var/www/html/index.html
              systemctl restart apache2
              EOF
}

resource "aws_security_group" "web-sg" {
  name = "${random_pet.sg.id}-sg"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // connectivity to ubuntu mirrors is required to run `apt-get update` and `apt-get install apache2`
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "web-address" {
  value = "${aws_instance.web.public_dns}:8080"
}


