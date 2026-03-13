data "hcloud_server" "existing" {
  name = var.existing_server_name
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventory.ini"
  content  = <<-EOF
  [netbird]
  ${data.hcloud_server.existing.ipv4_address} ansible_user=ubuntu ansible_ssh_private_key_file=${pathexpand("~/.ssh/id_ed25519")} ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
  EOF
}
