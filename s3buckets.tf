
resource "aws_s3_bucket" "web-app-s3" {
  
  bucket = "${local.env}-webapp-${local.name}"

  tags = {
    Environment = "${local.env}"
    bucketname  = "${local.env}-webapp-${local.name}"
  }
}

resource "aws_s3_bucket_website_configuration" "web-app-s3" {
  bucket = aws_s3_bucket.web-app-s3.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_versioning" "web-app-s3" {
  bucket = aws_s3_bucket.web-app-s3.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "web-app-s3" {
  bucket = aws_s3_bucket.web-app-s3.id
  
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "web-app-s3" {
  bucket = aws_s3_bucket.web-app-s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "web-app-s3" {
  
  depends_on = [
    aws_s3_bucket_ownership_controls.web-app-s3,
    aws_s3_bucket_public_access_block.web-app-s3,
  ]

  bucket = aws_s3_bucket.web-app-s3.id
  acl    = "public-read"
}

output "website_url" {
  value = "http://${aws_s3_bucket.web-app-s3.bucket}.s3-website.${var.region}.amazonaws.com"
}

