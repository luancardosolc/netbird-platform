# Network Design

## Public Ports

- `80/tcp`
- `443/tcp`
- `3478/udp`

## Protected Port

- `8200/tcp` for OpenBao

## VPN Network

- Target mesh CIDR: `10.100.0.0/16`

## Access Model

The VPS keeps public reachability only for NetBird bootstrap and relay traffic. OpenBao is reachable from VPN peers only.
