resource "google_service_account" "github_actions_sa" {
  account_id   = var.service_account_name
  display_name = "GitHub Actions Service Account"
  project      = var.project_id
}

resource "google_project_iam_member" "artifact_registry_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"

  member = "serviceAccount:${google_service_account.github_actions_sa.email}"
}

resource "google_project_iam_member" "gke_developer" {
  project = var.project_id
  role    = "roles/container.developer"

  member = "serviceAccount:${google_service_account.github_actions_sa.email}"
}