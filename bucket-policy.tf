# S3 bucket policy
resource "aws_s3_bucket_policy" "bucket-policy" {
    bucket = aws_s3_bucket.web-app-s3.id

    policy = <<POLICY
    {
    "Id": "Policy",
    "Statement": [
        {
        "Action": [
            "s3:GetObject"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.web-app-s3.bucket}/*",
        "Principal": {
            "AWS": [
            "*"
            ]
        }
        }
    ]
    }
POLICY
}