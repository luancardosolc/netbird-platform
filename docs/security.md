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
- A dedicated OpenBao policy and scoped token were created for read-only access to `kv/netbird/operational`
- The scoped token can be stored in the macOS Keychain instead of plaintext local files

## Remaining Hardening

- Keep the current OpenBao token in place until the scoped replacement is adopted everywhere by operator choice
- Replace the bootstrap root-token workflow with a broader scoped OpenBao operator token for additional day-2 tasks beyond NetBird secret reads
- Confirm VPN-only reachability before treating the system as production-ready
