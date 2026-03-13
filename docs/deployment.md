# Deployment

## Flow

1. Discover the existing Hetzner VPS with OpenTofu.
2. Generate an Ansible inventory for the reused host.
3. Verify Docker on the host.
4. Bootstrap the NetBird self-hosted stack.
5. Configure host firewall rules.
6. Enroll peers and validate VPN-only access to OpenBao.
7. Store or rotate NetBird operational secrets in OpenBao under `kv/netbird/operational`.

## Domain Strategy

The default zero-cost bootstrap domain is `sslip.io`, derived from the current VPS IP. This avoids manual DNS as an initial deployment blocker.

## Secret Source of Truth

The preferred source of truth for `make enroll-server` and `make enroll-macbook` is OpenBao:

- `OPENBAO_ADDR`
- `OPENBAO_TOKEN`
- `OPENBAO_SKIP_VERIFY`
- `OPENBAO_NETBIRD_SECRET_PATH` (optional, defaults to `kv/data/netbird/operational`)

The local `.state/netbird-admin.env` file is only a non-secret fallback placeholder and should not hold live credentials.
