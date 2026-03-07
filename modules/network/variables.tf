variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Subnet region"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "subnet_cidr" {
  description = "Subnet CIDR range"
  type        = string
}