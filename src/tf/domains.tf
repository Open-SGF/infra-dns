locals {
  opensgf_org = "opensgf.org"
}

data "cloudflare_zone" "opensgf_org" {
  filter = {
    name = local.opensgf_org
  }
}
