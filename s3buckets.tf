# Create S3 Bucket per environment
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket" "webapps3bucket" {

  # for_each Meta-Argument
  for_each = {
    dev  = "dev-webapp-bucket"
    stg = "stg-webapp-bucket"
    prd = "prd-webapp-bucket"
  }

  bucket = "${each.key}-${each.value}"
  acl    = "private"

  tags = {
    Environment = each.key
    bucketname  = "${each.value}"
  }
}