locals {
  opensgf_com        = "opensgf.com"
  opensgf_org        = "opensgf.org"
  takeshelternow_com = "takeshelternow.com"
  takeshelternow_org = "takeshelternow.org"
}

data "cloudflare_zone" "opensgf_com" {
  filter = {
    name = local.opensgf_com
  }
}

data "cloudflare_zone" "opensgf_org" {
  filter = {
    name = local.opensgf_org
  }
}

data "cloudflare_zone" "takeshelternow_com" {
  filter = {
    name = local.takeshelternow_com
  }
}

data "cloudflare_zone" "takeshelternow_org" {
  filter = {
    name = local.takeshelternow_org
  }
}
