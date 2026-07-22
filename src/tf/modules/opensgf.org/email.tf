locals {
  opensgf_org_dkim_public_key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCBg523G9QdNcT6cq37atcMd1Ma3P6qR0V8UOPRLlvOjVtee4i6FvH4qUuy6VfO2TJa8GzTGoL2vtH19DARgvAbMTh+0py/0NMa2gt8A/8sQnCV3AJTjgr2WAJbUrVll94iBI9dVJ22Wl2OhRsQ6VxThRFm3IAd3QE3gMnVCgrmBQIDAQAB"
  ses_email_identity          = "opensgf.org"
}

data "aws_sesv2_email_identity" "opensgf_org" {
  email_identity = local.ses_email_identity
}

data "aws_sesv2_email_identity_mail_from_attributes" "opensgf_org" {
  email_identity = data.aws_sesv2_email_identity.opensgf_org.email_identity
}

resource "cloudflare_dns_record" "opensgf_org_mx" {
  for_each = {
    primary = {
      content  = "aspmx.l.google.com"
      priority = 1
    }
    alt1 = {
      content  = "alt1.aspmx.l.google.com"
      priority = 5
    }
    alt2 = {
      content  = "alt2.aspmx.l.google.com"
      priority = 5
    }
    alt3 = {
      content  = "aspmx3.googlemail.com"
      priority = 10
    }
    alt4 = {
      content  = "aspmx2.googlemail.com"
      priority = 10
    }
  }

  zone_id  = var.zone_id
  name     = "@"
  type     = "MX"
  content  = each.value.content
  priority = each.value.priority
  comment  = var.comment
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "opensgf_org_dmarc" {
  zone_id = var.zone_id
  name    = "_dmarc"
  type    = "TXT"
  content = "v=DMARC1; p=none; pct=100; rua=mailto:re+jgwembv5qxs@dmarc.postmarkapp.com; sp=none; adkim=s; aspf=r;"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "opensgf_org_dkim" {
  zone_id = var.zone_id
  name    = "google._domainkey"
  type    = "TXT"
  content = "v=DKIM1; k=rsa; p=${local.opensgf_org_dkim_public_key}"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "opensgf_org_spf" {
  zone_id = var.zone_id
  name    = "@"
  type    = "TXT"
  content = "v=spf1 include:_spf.google.com -all"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "opensgf_org_google_site_verification" {
  zone_id = var.zone_id
  name    = "@"
  type    = "TXT"
  content = "google-site-verification=zPSqK63HAFzSqO6WJeDsDrkG9XzBMsDPtNgtEf7rxoY"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "opensgf_org_ses_dkim" {
  for_each = toset(data.aws_sesv2_email_identity.opensgf_org.dkim_signing_attributes[0].tokens)

  zone_id = var.zone_id
  name    = "${each.value}._domainkey"
  type    = "CNAME"
  content = "${each.value}.dkim.amazonses.com"
  comment = var.comment
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "opensgf_org_ses_mail_from_mx" {
  zone_id  = var.zone_id
  name     = data.aws_sesv2_email_identity_mail_from_attributes.opensgf_org.mail_from_domain
  type     = "MX"
  content  = "feedback-smtp.${var.aws_region}.amazonses.com"
  priority = 10
  comment  = var.comment
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "opensgf_org_ses_mail_from_spf" {
  zone_id = var.zone_id
  name    = data.aws_sesv2_email_identity_mail_from_attributes.opensgf_org.mail_from_domain
  type    = "TXT"
  content = "v=spf1 include:amazonses.com -all"
  comment = var.comment
  proxied = false
  ttl     = 1
}
