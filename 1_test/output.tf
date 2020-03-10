#--- test/output.tf ---

output "output_aws_vpc_vpc1_id" {
  value       = aws_vpc.vpc1.id
  description = "The id of the new VPC"
}
