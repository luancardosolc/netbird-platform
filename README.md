# NetBird Platform

Automation-first project to extend the existing Hetzner VPS used by `openbao-platform` with a self-hosted NetBird deployment, MacBook peer enrollment, and VPN-only access to OpenBao.

## Quick Start

1. Run `make bootstrap`.
2. Review `.env.example` and export the needed variables.
3. Run `make lint`.
4. Run `make test`.
5. Run `make deploy`.
6. Store the operational NetBird secret in OpenBao at `kv/netbird/operational`.
7. Run `make enroll-server`.
8. Run `make enroll-macbook`.

## Notes

- The platform reuses the existing Hetzner VPS from `openbao-platform`; it does not create a new server.
- `make enroll-server` and `make enroll-macbook` prefer loading `NETBIRD_SETUP_KEY` and `NETBIRD_DOMAIN` from OpenBao via `OPENBAO_ADDR`, `OPENBAO_TOKEN`, and `OPENBAO_NETBIRD_SECRET_PATH`.
- If `OPENBAO_TOKEN` is unset on macOS, the enrollment scripts also try the Keychain item `openbao-netbird-read-token`.
- `make store-openbao-netbird-token` stores a scoped OpenBao read token in the macOS Keychain without changing the current working token flow.
- The local `.state/netbird-admin.env` file is now only a fallback path and should not be treated as the primary secret store.
- `make enroll-macbook` requires one-time local admin privileges on macOS to install and start the NetBird daemon.

## Docs

- [docs/architecture.md](docs/architecture.md)
- [docs/network-design.md](docs/network-design.md)
- [docs/security.md](docs/security.md)
- [docs/deployment.md](docs/deployment.md)
- [docs/automation.md](docs/automation.md)
- [docs/project-management.md](docs/project-management.md)
