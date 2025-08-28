provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "event_bucket" {
  bucket = var.lambda_s3_bucket

  versioning {
    enabled = true
  }

  tags = {
    Name = "EventBucket"
  }
}

data "aws_s3_bucket_object" "lambda_zip" {
  bucket = var.lambda_s3_bucket
  key    = var.lambda_s3_key
}

resource "aws_lambda_function" "processor" {
  function_name = "file_processor_lambda"
  role          = var.lambda_role_arn
  handler       = "index.handler"   # Change if your Lambda handler differs
  runtime       = "python3.9"       # Change runtime if needed

  s3_bucket = var.lambda_s3_bucket
  s3_key    = var.lambda_s3_key

  depends_on = [aws_s3_bucket.event_bucket]
}
