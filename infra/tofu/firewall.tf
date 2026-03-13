resource "hcloud_firewall" "shared" {
  name = var.existing_firewall_name

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "80"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "443"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
    protocol   = "udp"
    port       = tostring(var.netbird_turn_port)
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  apply_to {
    server = data.hcloud_server.existing.id
  }
}

locals {
  required_public_ports = [
    "22/tcp",
    "80/tcp",
    "443/tcp",
    "${var.netbird_turn_port}/udp",
  ]

  protected_openbao_port = "${var.openbao_port}/tcp"
}
