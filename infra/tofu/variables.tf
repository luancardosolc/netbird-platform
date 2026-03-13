variable "hetzner_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "existing_server_name" {
  description = "Name of the existing Hetzner server already running OpenBao"
  type        = string
  default     = "openbao-platform-prod-openbao"
}

variable "existing_firewall_name" {
  description = "Name of the existing Hetzner firewall attached to the shared host"
  type        = string
  default     = "openbao-platform-prod-fw"
}

variable "netbird_domain" {
  description = "Public hostname used by NetBird"
  type        = string
}

variable "netbird_turn_port" {
  description = "TURN relay port"
  type        = number
  default     = 3478
}

variable "openbao_port" {
  description = "OpenBao service port"
  type        = number
  default     = 8200
}

variable "vpn_cidr" {
  description = "Target NetBird VPN CIDR"
  type        = string
  default     = "10.100.0.0/16"
}
