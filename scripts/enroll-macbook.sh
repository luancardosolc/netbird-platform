#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=SC1091
source "${ROOT_DIR}/scripts/load-netbird-secrets.sh"

if [[ -z "${NETBIRD_SETUP_KEY:-}" || -z "${NETBIRD_DOMAIN:-}" ]]; then
  echo "NETBIRD_SETUP_KEY and NETBIRD_DOMAIN must be available from OpenBao or local fallback state" >&2
  exit 1
fi

if ! command -v netbird >/dev/null 2>&1; then
  brew install netbirdio/tap/netbird
fi

if ! sudo -n true >/dev/null 2>&1; then
  echo "local admin access is required once on macOS to install/start the daemon" >&2
  echo "run:" >&2
  echo "  sudo netbird service install" >&2
  echo "  sudo netbird service start" >&2
  echo "  sudo netbird up --management-url https://${NETBIRD_DOMAIN} --admin-url https://${NETBIRD_DOMAIN} --setup-key ${NETBIRD_SETUP_KEY} --hostname macbook" >&2
  exit 1
fi

sudo netbird service install >/dev/null 2>&1 || true
sudo netbird service start >/dev/null 2>&1 || true
sudo netbird up \
  --management-url "https://${NETBIRD_DOMAIN}" \
  --admin-url "https://${NETBIRD_DOMAIN}" \
  --setup-key "${NETBIRD_SETUP_KEY}" \
  --hostname "macbook"

netbird status --detail
