variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "lambda_role_arn" {
  description = "Existing IAM role ARN for Lambda"
  type        = string
}

variable "lambda_code_path" {
  description = "Local path to Lambda deployment ZIP file"
  type        = string
  default     = "lambda_code/my_lambda.zip"   # You can override in terraform.tfvars or CLI
}

variable "lambda_s3_bucket" {
  description = "S3 bucket name (for event source or other purposes)"
  type        = string
}
