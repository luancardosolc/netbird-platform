#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OPENBAO_STATE="${ROOT_DIR}/../openbao-platform/infra/tofu/terraform.tfstate"

# shellcheck disable=SC1091
source "${ROOT_DIR}/scripts/load-netbird-secrets.sh"

if [[ -z "${NETBIRD_SETUP_KEY:-}" || -z "${NETBIRD_DOMAIN:-}" ]]; then
  echo "NETBIRD_SETUP_KEY and NETBIRD_DOMAIN must be available from OpenBao or local fallback state" >&2
  exit 1
fi

SERVER_IP="${NETBIRD_SERVER_IP:-$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["outputs"]["server_public_ip"]["value"])' "${OPENBAO_STATE}")}"
SSH_KEY="${NETBIRD_SSH_PRIVATE_KEY:-/Users/macbook/.ssh/id_ed25519}"

ssh -o StrictHostKeyChecking=no -i "${SSH_KEY}" "ubuntu@${SERVER_IP}" \
  "command -v netbird >/dev/null 2>&1 || (curl -fsSL https://pkgs.netbird.io/install.sh | sudo sh)"

ssh -o StrictHostKeyChecking=no -i "${SSH_KEY}" "ubuntu@${SERVER_IP}" \
  "sudo netbird down >/dev/null 2>&1 || true; \
   sudo netbird up --management-url https://${NETBIRD_DOMAIN} \
     --admin-url https://${NETBIRD_DOMAIN} \
     --setup-key ${NETBIRD_SETUP_KEY} \
     --hostname openbao-platform-host \
     --log-file console && \
   sudo netbird status --detail"
