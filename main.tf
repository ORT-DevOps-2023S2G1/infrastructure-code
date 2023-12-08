terraform {

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
    region  = "us-east-1"
    access_key = "ASIA56TDW4WQMVEJFQV5"
    secret_key = "66BblgCpRkJCqWwBdOmPq6McXduNL3EY61hA0kqB"
    token = "FwoGZXIvYXdzEGwaDBTOWC9POwSZq+VPZSLJAXYLObzPr4ROoFD1M1sYETgiNJXTJxpMJvkHqHptFCf9Ghjb3WBduMJBjRskf5MToW0zWFUcF4krYQKqSA43oeLkJyHrhmFIiXzYGcf6hcZOYUOuX3VH+jDecKwywkzuvoAi6W2mMV6YXBrmH8yDiju9zlV46xsUjGRjt/+ZnWqhYiHemJFJX+99NorCrQ8uHrxxM8QD4wz8BcFWrHADvHUOv9fMgme3RpU/j9BqWsFIpWG/CxT3kdxCTujVguVL6dxAl5CjnAFz7yjMwM2rBjIt33JmLWdEH/zfaCXWkkW1y/WmbF4lEoWZLBxwGLab7oV/vh9590hCaJXzpCow"
}


