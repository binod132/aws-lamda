provider "aws" {
  region = var.aws_region
}

# Create the S3 bucket to hold files to trigger Lambda
resource "aws_s3_bucket" "event_bucket" {
  bucket = var.lambda_s3_bucket

  versioning {
    enabled = true
  }

  tags = {
    Name = "EventBucket"
  }
}

# Data source to reference the Lambda deployment package zip in S3
data "aws_s3_bucket_object" "lambda_zip" {
  bucket = var.lambda_s3_bucket
  key    = var.lambda_s3_key
}

# Lambda function resource referencing existing IAM role and S3 code
resource "aws_lambda_function" "processor" {
  function_name = "file_processor_lambda"
  role          = var.lambda_role_arn
  handler       = "index.handler"   # Adjust as per your Lambda code
  runtime       = "python3.9"       # Adjust runtime if needed

  s3_bucket = var.lambda_s3_bucket
  s3_key    = var.lambda_s3_key

  # Explicit dependency to ensure S3 bucket exists before Lambda creation
  depends_on = [aws_s3_bucket.event_bucket]
}
