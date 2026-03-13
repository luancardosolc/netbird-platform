# Security

## Controls

- Reuse the existing hardened Docker host
- Expose only the ports required by NetBird
- Restrict OpenBao `8200/tcp` to VPN-originated traffic
- Keep deployment automated and reproducible

## Pending Hardening

- Replace any bootstrap credentials with scoped operational credentials
- Review NetBird dashboard admin credentials storage
- Confirm VPN-only reachability before treating the system as production-ready
