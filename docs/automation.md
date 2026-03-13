# Automation

## Operator Commands

- `make bootstrap`
- `make lint`
- `make test`
- `make deploy`
- `make destroy`
- `make enroll-server`
- `make enroll-macbook`
- `make store-openbao-netbird-token`

## Automation Principles

- Host discovery only, no new VPS creation
- Docker-based service deployment
- Scriptable client enrollment
- CI validation on every change
- OpenBao-backed secret retrieval for day-2 enrollment flows
- macOS Keychain support for scoped OpenBao token storage
