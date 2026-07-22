variable "environment" {
  description = "The environment for which the RDS instance is being created (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "The ID of the VPC where the RDS instance will be deployed."
  type        = string
}

variable "private_subnets_ids" {
  description = "A list of subnet IDs for the RDS instance."
  type        = list(string)
}