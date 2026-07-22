terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

locals {
  records = {
    staging = {
      name    = "staging"
      type    = "CNAME"
      content = "take-shelter-now-staging.netlify.app"
      proxied = false
      ttl     = 1
    }
    apex = {
      name    = "@"
      type    = "CNAME"
      content = "apex-loadbalancer.netlify.com"
      proxied = false
      ttl     = 1
    }
    www = {
      name    = "www"
      type    = "CNAME"
      content = "take-shelter-now.netlify.app"
      proxied = false
      ttl     = 1
    }
    google_site_verification = {
      name    = "@"
      type    = "TXT"
      content = "\"google-site-verification=GbK6KC1-yQKwtWzmiSZmHKl_arB8dBW1t9NGi7DW_O8\""
      proxied = false
      ttl     = 3600
    }
  }
}

resource "cloudflare_dns_record" "core" {
  for_each = local.records

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  content = each.value.content
  comment = var.comment
  proxied = each.value.proxied
  ttl     = each.value.ttl
}
