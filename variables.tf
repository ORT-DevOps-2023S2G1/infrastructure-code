locals {
    infra_env = terraform.workspace
}

variable "region" {
    default = "us-east-1"
    description = "AWS region"
    type = string
}

variable "instance_type" {
    default = "t2.micro"
    description = "EC2 Instance Type"
    type = string
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
    description = "Main VPC CIDR"
    type = string
}
