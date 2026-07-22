terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

locals {
  records = {
    staging_api_acm_validation = {
      name    = "_10ccd4d45e94d9ebd98973024c2b3999.staging-sgf-meetup-api"
      type    = "CNAME"
      content = "_14b90a0fc34e301270ab0e424ff8a24b.xlfgrmvvlj.acm-validations.aws"
      proxied = false
      ttl     = 1
    }
    api_acm_validation = {
      name    = "_2c8f9d8029b67250800d4dca3f60640c.sgf-meetup-api"
      type    = "CNAME"
      content = "_b889a9583d89b90d5c09cee186637d30.mhbtsbpdnt.acm-validations.aws"
      proxied = false
      ttl     = 1
    }
    docs = {
      name    = "docs"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    files = {
      name    = "files"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    healthiermo = {
      name    = "healthiermo"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    apex = {
      name    = "@"
      type    = "CNAME"
      content = "open-sgf.netlify.app"
      proxied = false
      ttl     = 1
    }
    outline = {
      name    = "outline"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    api = {
      name    = "sgf-meetup-api"
      type    = "CNAME"
      content = "d-qfoh6obcri.execute-api.us-east-2.amazonaws.com"
      proxied = false
      ttl     = 1
    }
    staging_good_dads = {
      name    = "staging-good-dads"
      type    = "CNAME"
      content = "middleout.levizitting.com"
      proxied = true
      ttl     = 1
    }
    staging_api = {
      name    = "staging-sgf-meetup-api"
      type    = "CNAME"
      content = "d-lydsl5yfwc.execute-api.us-east-2.amazonaws.com"
      proxied = false
      ttl     = 1
    }
    volunteer = {
      name    = "volunteer"
      type    = "CNAME"
      content = "middleout.levizitting.com"
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
