#VPC
output "vpc_id" {
  description = "VPC ID"
  value = module.vpc.vpc_id
}

#EKS
output "eks_cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value = module.eks.cluster_endpoint
}

output "eks_cluster_id" {
  description = "EKS Cluster ID"
  value = module.eks.cluster_id
}

#ECR
output "ecr_repository_urls" {
  description = "ECR Repository URL"
  value = module.ecr.repository_urls
}

#RDS
output "rds_endpoint" {
  description = "RDS Endpoint"
  value     = module.rds.db_endpoint
  sensitive = false
}   