variable "aws_region" {
  description = "AWS region where the ECR repo will be created"
  type        = string
  default     = "ap-south-1"
}

variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "my-app-backend"
}

variable "environment" {
  description = "Environment tag (e.g., dev, staging, prod)"
  type        = string
  default     = "prod"
}

variable "project" {
  description = "Project tag"
  type        = string
  default     = "sample-app"
}
