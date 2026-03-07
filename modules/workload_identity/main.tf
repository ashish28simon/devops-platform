resource "google_iam_workload_identity_pool" "github_pool" {
  workload_identity_pool_id = "github-pool"
  display_name              = "GitHub Actions Pool"
  description               = "Identity pool for GitHub Actions"
  project                   = var.project_id
}

resource "google_iam_workload_identity_pool_provider" "github_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"

  project = var.project_id

  display_name = "GitHub Provider"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
  }
}

resource "google_service_account_iam_member" "github_actions_binding" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"

  role = "roles/iam.workloadIdentityUser"

  member = "principalSet://iam.googleapis.com/projects/${var.project_id}/locations/global/workloadIdentityPools/github-pool/attribute.repository/${var.github_repo}"
}