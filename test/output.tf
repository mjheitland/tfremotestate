#--- test/output.tf ---

output "output_s3_bucket_arn" {
  value       = aws_s3_bucket.s3_bucket_mybucket.arn
  description = "The ARN of the s3 bucket"
}
