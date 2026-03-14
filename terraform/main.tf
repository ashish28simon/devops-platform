module "network" {
  source = "../modules/network"

  project_id  = var.project_id
  region      = var.region

  vpc_name    = "devops-platform-vpc"
  subnet_name = "devops-platform-subnet"
  subnet_cidr = "10.10.0.0/24"
}

module "artifact_registry" {
  source = "../modules/artifact_registry"

  project_id      = var.project_id
  region          = var.region
  repository_name = "microservices-repo"
}

module "iam" {
  source = "../modules/iam"

  project_id           = var.project_id
  service_account_name = "github-actions-sa"
}

module "workload_identity" {
  source = "../modules/workload_identity"

  project_id            = var.project_id
  github_repo           = "ashish28simon/devops-platform"
  service_account_email = module.iam.service_account_email
}

module "gke" {
  source = "../modules/gke"

  project_id = var.project_id
  zone       = var.zone

  network    = module.network.vpc_name
  subnetwork = module.network.subnet_name
  node_service_account = module.iam.github_actions_sa_email
}