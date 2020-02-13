#--- output.tf ---

output "output_s3_bucket_arn" {
  value       = aws_s3_bucket.s3_bucket_tfstate.arn
  description = "The ARN of the s3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.dynamodb_table_tfstatelocks.name
  description = "The name of the dynamodb table that stores the terraform locks"
}
