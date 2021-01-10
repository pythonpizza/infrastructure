locals {
  main_domain = "python.pizza"
  fulldomain  = "${var.domain}.${local.main_domain}"
}

data "cloudflare_zones" "root" {
  filter {
    name = local.main_domain
  }
}

resource "cloudflare_record" "domain" {
  zone_id = data.cloudflare_zones.root.zones[0].id
  name    = var.domain
  value   = aws_s3_bucket.website.website_endpoint
  type    = "CNAME"
  ttl     = 1
  proxied = true
}
