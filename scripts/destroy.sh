#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STATE_INVENTORY="${ROOT_DIR}/infra/tofu/inventory.ini"

if [[ ! -f "${STATE_INVENTORY}" ]]; then
  echo "inventory not found, nothing to destroy" >&2
  exit 1
fi

ansible -i "${STATE_INVENTORY}" netbird -b -m shell -a 'cd /opt/netbird && docker compose down || true'
