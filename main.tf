terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
        }
    }

    required_version = ">= 1.2.0"

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


