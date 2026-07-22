variable "environment" {
  description = "The environment for which the EKS cluster is being created (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "cluster_version" {
  description = "The version of the EKS cluster."
  type        = string
  default     = "1.36"
}

variable "private_subnet_ids" {
  description = "A list of subnet IDs for the EKS cluster."
  type        = list(string)
}

variable "node_instance_type" {
  description = "The instance type for the EKS node group."
  type        = list(string)
  default     = ["t3.micro"]
}

variable "node_desired_size" {
  description = "The desired number of nodes in the EKS node group."
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "The maximum number of nodes in the EKS node group."
  type        = number
  default     = 3
}

variable "node_min_size" {
  description = "The minimum number of nodes in the EKS node group."
  type        = number
  default     = 1
}