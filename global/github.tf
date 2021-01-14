locals {
  infrastructure_repo = "infrastructure"
}

resource "github_actions_secret" "aws_access_key_id" {
  repository      = local.infrastructure_repo
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = aws_iam_access_key.key.id
}

resource "github_actions_secret" "aws_access_key_secret" {
  repository      = local.infrastructure_repo
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = aws_iam_access_key.key.secret
}

resource "github_actions_secret" "cloudflare_token" {
  repository      = local.infrastructure_repo
  secret_name     = "TF_VAR_CLOUDFLARE_TOKEN"
  plaintext_value = cloudflare_api_token.ci.value
}

resource "github_actions_secret" "cloudflare_zone_id" {
  repository      = local.infrastructure_repo
  secret_name     = "CLOUDFLARE_ZONE_ID"
  plaintext_value = local.zone_id
}
