# Create S3 Bucket per workspace
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket" "webapps3bucket" {

  bucket = "${terraform.workspace}-webapp-bucket"

  tags = {
    Environment = "${terraform.workspace}"
    bucketname  = "${terraform.workspace}-webapp-bucket"
  }
}