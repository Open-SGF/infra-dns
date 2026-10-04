variable "cloudflare_api_token" {
  description = "Cloudflare API token with DNS edit and Tunnel read permissions"
  type        = string
  sensitive   = true
}

variable "public_edge_target" {
  description = "Target hostname for services routed through the public edge"
  type        = string
  default     = "public-edge.levizitting.com"
}

variable "aws_region" {
  description = "AWS region containing the SES identity"
  type        = string
  default     = "us-east-2"
}
