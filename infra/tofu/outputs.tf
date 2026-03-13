output "server_public_ip" {
  value = data.hcloud_server.existing.ipv4_address
}

output "server_name" {
  value = data.hcloud_server.existing.name
}

output "netbird_domain" {
  value = var.netbird_domain
}

output "required_public_ports" {
  value = local.required_public_ports
}

output "protected_openbao_port" {
  value = local.protected_openbao_port
}

output "vpn_cidr" {
  value = var.vpn_cidr
}
