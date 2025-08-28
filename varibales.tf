variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "lambda_role_arn" {
  description = "Existing IAM role ARN for Lambda"
  type        = string
}

variable "lambda_s3_bucket" {
  description = "S3 bucket name"
  type        = string
}

variable "lambda_s3_key" {
  description = "S3 key for Lambda deployment package"
  type        = string
}
