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

variable "create" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}

variable "ecs_task_execution_role_arn" {
  type = string
}

variable "microservices" {
    type    = set(string)
    default = ["orders", "payments", "products", "shipments"]
}

variable "url_image_container_microservices" {
    type = map(string)
    default = {
        "orders"= "ghcr.io/ort-devops-2023s2g1/orders-service-example:7090894486", 
        "payments"="ghcr.io/ort-devops-2023s2g1/payments-service-example:7107677406", 
        "products"="ghcr.io/ort-devops-2023s2g1/products-service-example:7080022031", 
        "shipments"="ghcr.io/ort-devops-2023s2g1/shipping-service-example:7080018234"
        }
}

variable "microservices_task_definitions" {
    type = map(string) 
    default = {
        "orders"= "orders_task_definition", 
        "payments"="payments_task_definition", 
        "products"="products_task_definition", 
        "shipments"="shipments_task_definition"
    }
}
