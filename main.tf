terraform {

    cloud {
      organization = "ORT-DevOps-2023S2G1"

      workspaces {
        name = "dev"
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
    region  = "us-east-1"
}


