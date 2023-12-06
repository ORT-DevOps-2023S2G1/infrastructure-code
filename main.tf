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
    access_key = "${terraform.AWS_ACCESS_KEY_ID_GONZA}"
    secret_key = "${terraform.AWS_SECRET_ACCESS_KEY_GONZA}"
    token = "${terraform.AWS_SESSION_TOKEN_GONZA}"
}


