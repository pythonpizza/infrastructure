data "cloudflare_api_token_permission_groups" "all" {}

data "cloudflare_zones" "root" {
  filter {
    name = "python.pizza"
  }
}

locals {
  zone_id = data.cloudflare_zones.root.zones[0].id
}


resource "cloudflare_api_token" "ci" {
  name = "ci"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.permissions["DNS Write"],
    ]

    resources = {
      "com.cloudflare.api.account.zone.${local.zone_id}" = "*"
    }
  }
}
