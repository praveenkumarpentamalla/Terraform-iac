provider "aws" {
  region = var.aws_region
}

# Create an ECR repository
resource "aws_ecr_repository" "latest" {
  name                 = var.repository_name
  image_tag_mutability = "IMMUTABLE" 

  # Encryption configuration
  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
    Project     = var.project
  }
}

# Outputs
output "repository_url" {
  value       = aws_ecr_repository.this.repository_url
  description = "The URL of the ECR repository"
}

output "repository_arn" {
  value       = aws_ecr_repository.this.arn
  description = "The ARN of the ECR repository"
}
