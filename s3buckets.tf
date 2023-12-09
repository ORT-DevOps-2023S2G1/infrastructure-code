# Create S3 bucket per workspace 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket" "webapps3" {
  
  bucket = "${local.env}-webapp-${local.name}"

  tags = {
    Environment = "${local.env}"
    bucketname  = "${local.env}-webapp-${local.name}"
  }
}