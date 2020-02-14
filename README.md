## Store Terraform state remotely 
(one bucket and one DynamoDB table per account storing all of your TF code):

Features:
+	Isolate state files with workspaces (dev and testing) or file layout (production)
+	Lock concurrent Terraform changes with DynamoDB table locks
+	Share Terraform state in an S3 bucket as a remote backend
+	Use a different bucket key for every module
+	Use versioning on S3 bucket: 
  versioning { enabled = true }
+	Prevent accidental deletion of the state bucket: 
  lifecycle { prevent_destroy = true }
+	Bucket must be encrypted in transit and in rest as the state file is containing secrets
  versioning { enabled = true }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
+	Use partial configuration for the backend:
place variables (bucket, region, dynamotable, encrypt) into a separate file “backend.hcl”,
leave only the key in TF: 
  terraform { backend s3 { key = “mymodule/terraform.tfstate” } } 
and run 
  terraform init -backend-configuration=backend.hcl”
