# Create S3 bucket per workspace 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket" "webapps3" {
  
  bucket = "${local.infra_env}-webapp-ort-devops-2023s2g1-1146"

  tags = {
    Environment = "${local.infra_env}"
    bucketname  = "${local.infra_env}-webapp-ort-devops-2023s2g1-1146"
  }
}