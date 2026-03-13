#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

grep -q 'getting-started.sh' "${ROOT_DIR}/infra/ansible/playbooks/install-netbird.yml"
grep -q 'docker compose up -d' "${ROOT_DIR}/infra/ansible/playbooks/install-netbird.yml"
grep -q 'netbirdio/netbird-server' "${ROOT_DIR}/docs/architecture.md"
grep -q 'NETBIRD_DOMAIN' "${ROOT_DIR}/scripts/deploy.sh"
