terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

locals {
  records = {
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
      content = "opensgf.netlify.app"
      proxied = false
      ttl     = 1
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
