# Deployment

## Flow

1. Discover the existing Hetzner VPS with OpenTofu.
2. Generate an Ansible inventory for the reused host.
3. Verify Docker on the host.
4. Bootstrap the NetBird self-hosted stack.
5. Configure host firewall rules.
6. Enroll peers and validate VPN-only access to OpenBao.

## Domain Strategy

The default zero-cost bootstrap domain is `sslip.io`, derived from the current VPS IP. This avoids manual DNS as an initial deployment blocker.
