provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "event_bucket" {
  bucket = var.lambda_s3_bucket

  tags = {
    Name = "EventBucket"
  }
}

# New separate resource for versioning (instead of deprecated block)
resource "aws_s3_bucket_versioning" "event_bucket_versioning" {
  bucket = aws_s3_bucket.event_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_s3_object" "lambda_zip" {
  bucket = var.lambda_s3_bucket
  key    = var.lambda_s3_key
}

resource "aws_lambda_function" "processor" {
  function_name = "file_processor_lambda"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.9"

  s3_bucket = var.lambda_s3_bucket
  s3_key    = var.lambda_s3_key

  depends_on = [
    aws_s3_bucket.event_bucket,
    aws_s3_bucket_versioning.event_bucket_versioning,
  ]
}
