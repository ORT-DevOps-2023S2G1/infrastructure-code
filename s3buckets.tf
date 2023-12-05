# Create S3 bucket per workspace 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket" "example" {
  
  bucket = "${terraform.workspace}-webapp-ort-devops-2023s2g1"

  tags = {
    Environment = "${terraform.workspace}"
    bucketname  = "${terraform.workspace}-webapp-ort-devops-2023s2g1"
  }
}