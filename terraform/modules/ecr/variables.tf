# ====================================================================
# 1. Create Environment Variable for ECR Repository Creation
# ====================================================================

variable "environment" {
  description = "The environment for which the ECR repository is being created (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

# ====================================================================
# 1. Create ECR Repository Variables - Users Service - Order Service - Products Service
# ====================================================================

variable "repository_names" {
  description = "A list of repository names to create in ECR."
  type        = list(string)
  default     = ["users-service", "orders-service", "products-service"]
}