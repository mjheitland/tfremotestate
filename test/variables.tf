#--- test/variables.tf ---

variable "region" {
  description = "AWS region we are deploying to"
  type        = string
}

variable "project_name" {
  description = "project name is used as resource tag"
  type        = string
}
