locals {
    env = terraform.workspace
    name = "proy-ort"
    exec-role-arn = "arn:aws:iam::959060567456:role/LabRole"
}

variable "region" {
    default = "us-east-1"
    description = "AWS region"
    type = string
}

variable "instance_type" {
    default = "t2.small"
    description = "EC2 Instance Type"
    type = string
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
    description = "Main VPC CIDR"
    type = string
}

variable "cloudwatch_group" {
    description = "CloudWatch group name."
    type = string
    default = "services-group"
}