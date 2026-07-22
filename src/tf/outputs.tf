output "cloudflare_zone_id" {
  description = "Cloudflare zone ID for managed zone"
  value       = data.cloudflare_zone.opensgf_org.id
}
