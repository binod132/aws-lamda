# Terraform
##Why the Error Happens

Terraform builds a dependency graph to determine the order in which resources are created. This graph is based primarily on explicit references between resources.

In the original scenario (not our final solution), the Lambda function:
Referenced an IAM role ARN for permissions
Loaded its code from an S3 object via the aws_s3_bucket_object data source
Although the Lambda block references the IAM role’s ARN, this does not guarantee Terraform will wait for:
The IAM role itself to be created
The IAM policy attachment to be applied
Since Terraform only sees an ARN string, it doesn’t treat the IAM policy attachment as a dependency. Therefore, it may try to create the Lambda function before the IAM role has the correct permissions — leading to a 403 AccessDenied error from AWS.

## Why Our Terraform Avoids This Error

We fixed the issue by using best practices:

Technique	Explanation
Existing IAM Role	We passed in a pre-created IAM role (lambda_role_arn), so Terraform didn’t need to manage IAM resources or handle race conditions.
Local ZIP File Upload	Instead of referencing a ZIP in S3 (via aws_s3_bucket_object), we used the filename argument to upload the code directly from the local file system.
Explicit depends_on	We used depends_on for safe ordering of the S3 bucket and versioning, although it wasn't needed for the IAM role since it's passed in.

This approach completely avoids the original issue.

## Best Practices Applied

Prefer direct ZIP upload using filename when possible to avoid unnecessary complexity with S3 object lookups.
Use existing IAM roles where possible, especially in environments where IAM permissions are restricted.
Use depends_on to enforce ordering when implicit dependencies are insufficient.
Keep resource dependencies clear and minimal to avoid race conditions.
