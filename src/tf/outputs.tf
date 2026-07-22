output "cloudflare_zone_ids" {
  description = "Cloudflare zone IDs for managed zones"
  value = {
    opensgf_com        = data.cloudflare_zone.opensgf_com.id
    opensgf_org        = data.cloudflare_zone.opensgf_org.id
    takeshelternow_com = data.cloudflare_zone.takeshelternow_com.id
    takeshelternow_org = data.cloudflare_zone.takeshelternow_org.id
  }
}
