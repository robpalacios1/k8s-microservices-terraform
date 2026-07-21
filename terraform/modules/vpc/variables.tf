# ====================================================================
# 1. VPC Variables
# ====================================================================

variable "aws_region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"
}

variable "main_vpc_cidr_block" {
  description = "CIDR Block for VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "environment" {
  description = "Environment Name"
  type = string
  default = "dev"
}

# ====================================================================
# 2. Public Subnets Variable
# ============================================================

variable "public_subnet_cidr_block" {
  description = "CIDR Block for Public Subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_az" {
  description = "Availability Zone for Public Subnets"
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

# ====================================================================
# 3. Private Subnets Variable
# ============================================================

variable "private_subnet_cidr_block" {
  description = "CIDR Block for Private Subnets"
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "private_subnet_az" {
  description = "Availability Zone for Private Subnets"
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}
