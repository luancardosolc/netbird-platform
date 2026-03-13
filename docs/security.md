# Security

## Controls

- Reuse the existing hardened Docker host
- Expose only the ports required by NetBird
- Restrict OpenBao `8200/tcp` to VPN-originated traffic
- Keep deployment automated and reproducible
- Store NetBird operational secrets in OpenBao at `kv/netbird/operational`
- Keep Trello and local state files free of plaintext credentials

## Current State

- The active setup key and dashboard admin password were migrated into OpenBao
- The previous reusable setup key was revoked after rotation
- Local plaintext fallback material was removed from the operator state file

## Remaining Hardening

- Keep the current OpenBao token in place until a scoped replacement is created and validated end-to-end
- Replace the bootstrap root-token workflow with a scoped OpenBao operator token for routine reads when that migration can be tested without breaking the working NetBird automation
- Confirm VPN-only reachability before treating the system as production-ready
