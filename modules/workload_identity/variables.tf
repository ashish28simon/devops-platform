variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository in format owner/repo"
  type        = string
}

variable "service_account_email" {
  description = "Service account email"
  type        = string
}