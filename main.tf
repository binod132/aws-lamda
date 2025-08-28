provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "event_bucket" {
  bucket = var.lambda_s3_bucket

  tags = {
    Name = "EventBucket"
  }
}

resource "aws_s3_bucket_versioning" "event_bucket_versioning" {
  bucket = aws_s3_bucket.event_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_lambda_function" "processor" {
  function_name = "file_processor_lambda"
  role          = var.lambda_role_arn
  handler       = "index.handler"  # adjust based on your code
  runtime       = "python3.9"      # or your runtime

  filename         = var.lambda_code_path
  source_code_hash = filebase64sha256(var.lambda_code_path)

  depends_on = [
    aws_s3_bucket.event_bucket,
    aws_s3_bucket_versioning.event_bucket_versioning,
  ]
}
