terraform {
  backend "gcs" {
    bucket  = "devops-platform-terraform-state"
    prefix  = "devops-platform"
  }
}