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

}

provider "aws" {
    region  = var.region
}