locals {
    env = terraform.workspace
    #changing name will affect github actions runs
    name = "ort" 
    exec-role-arn = "arn:aws:iam::637483454218:role/LabRole"
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
    type = string
}

variable "cloudwatch_group" {
    description = "CloudWatch group name."
    type = string
    default = "services-group"
}

variable "public_subnet_count" {
    description = "Number of public subnets."
    type        = number
    default     = 2
}

variable "services" {
    description = "Nombres de servicios a desplegar"
    type        = set(string)
    default     = [
        "payments",
        "products",
        "shipping",
        #"orders",
    ]
}