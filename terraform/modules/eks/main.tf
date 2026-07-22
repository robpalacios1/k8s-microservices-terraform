provider "aws" {
  region = "us-east-1"
}

# ====================================================================
# 1. IAM Role for EKS Cluster (control plane)
# ====================================================================

resource "aws_iam_role" "eks_cluster_role" {
    name = "dev-eks-cluster-role"

    assume_role_policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "eks.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    })

    tags = {
      Name        = "dev-eks-cluster-role"
      Environment = "dev"
    }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
    role       = aws_iam_role.eks_cluster_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}