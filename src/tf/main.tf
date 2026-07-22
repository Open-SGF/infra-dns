locals {
  dns_record_comment = "managedBy=tf,repo=opensgf/infra-dns"
}

module "opensgf_com" {
  source = "./modules/opensgf.com"

  zone_id = data.cloudflare_zone.opensgf_com.id
  comment = local.dns_record_comment
}

module "opensgf_org" {
  source = "./modules/opensgf.org"

  zone_id = data.cloudflare_zone.opensgf_org.id
  comment = local.dns_record_comment
}

module "takeshelternow_com" {
  source = "./modules/takeshelternow.com"

  zone_id = data.cloudflare_zone.takeshelternow_com.id
  comment = local.dns_record_comment
}

module "takeshelternow_org" {
  source = "./modules/takeshelternow.org"

  zone_id = data.cloudflare_zone.takeshelternow_org.id
  comment = local.dns_record_comment
}
