output "repository_urls" {
    description = "ECR Repository URLs for one by one services"
    value = {
        for name, repo in aws_ecr_repository.this : name => repo.repository_url
    }
}

output "repository_arns" {
    description = "ECR Repository ARNs for one by one services"
    value = {
        for name, repo in aws_ecr_repository.this : name => repo.arn
    }
}