# Architecture

## Goal

Run NetBird on the same Hetzner VPS already hosting OpenBao, without provisioning a second server.

## Components

- Existing Hetzner VPS
- OpenBao container stack
- NetBird self-hosted stack based on the combined `netbirdio/netbird-server`
- NetBird client on the MacBook

## Topology

Public access stays limited to the NetBird control plane and relay endpoints.
OpenBao is moved behind the VPN path and only reachable through the NetBird mesh once the peer enrollment is complete.
