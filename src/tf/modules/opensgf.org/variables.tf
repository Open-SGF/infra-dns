variable "zone_id" {
  description = "Cloudflare zone ID for opensgf.org"
  type        = string
}

variable "comment" {
  description = "Comment applied to managed DNS records"
  type        = string
}

variable "k3s_tunnel_target" {
  description = "Cloudflare Tunnel hostname for k3s applications"
  type        = string
}

variable "aws_region" {
  description = "AWS region containing the SES identity"
  type        = string
}
