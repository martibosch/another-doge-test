# Base repository
resource "github_repository" "repo" {
  name        = var.gh_repo_name # "doge-test"
  description = "Test terraform setup for cookiecutter-django-doge."
  visibility  = "public"

  allow_merge_commit = false

  auto_init = false
  # gitignore_template = "Terraform"
  # license_template   = "gpl-3.0"
}

data "github_user" "user" {
  username = var.gh_username
}

## Secrets
resource "github_actions_secret" "do_token" {
  repository      = github_repository.repo.name
  secret_name     = "do_token"
  plaintext_value = var.do_token
}

resource "github_actions_secret" "tf_api_token" {
  repository      = github_repository.repo.name
  secret_name     = "tf_api_token"
  plaintext_value = var.tf_api_token
}

resource "github_actions_secret" "ssh_key" {
  repository      = github_repository.repo.name
  secret_name     = "ssh_key"
  plaintext_value = tls_private_key.ssh_key.private_key_pem
}


# Branches
## Required branches
# resource "github_branch" "main" {
#   repository = github_repository.repo.name
#   branch     = "main"
# }

resource "github_branch" "staging" {
  repository = github_repository.repo.name
  branch     = "staging"
}

resource "github_branch" "develop" {
  repository = github_repository.repo.name
  branch     = "develop"
}
