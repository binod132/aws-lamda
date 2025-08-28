output "s3_bucket_name" {
  value = aws_s3_bucket.event_bucket.bucket
}

output "lambda_function_arn" {
  value = aws_lambda_function.lambda.arn
}
