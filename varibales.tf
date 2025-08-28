variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "lambda_role_arn" {
  description = "Existing IAM role ARN for Lambda"
  type        = string
}

variable "lambda_code_path" {
  description = "Local path to Lambda ZIP file"
  type        = string
  default     = "lambda_code/my_lambda.zip"
}

variable "lambda_s3_bucket" {
  description = "Unique name for the S3 bucket"
  type        = string
}
