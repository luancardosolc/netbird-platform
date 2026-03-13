#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STATE_FILE="${ROOT_DIR}/.state/netbird-admin.env"

load_from_openbao() {
  local addr token path skip_verify response

  addr="${OPENBAO_ADDR:-}"
  token="${OPENBAO_TOKEN:-}"
  path="${OPENBAO_NETBIRD_SECRET_PATH:-kv/data/netbird/operational}"
  skip_verify="${OPENBAO_SKIP_VERIFY:-true}"

  if [[ -z "${addr}" || -z "${token}" ]]; then
    return 1
  fi

  local curl_args=(-fsS -H "X-Vault-Token: ${token}")
  if [[ "${skip_verify}" == "true" ]]; then
    curl_args+=(-k)
  fi

  response="$(curl "${curl_args[@]}" "${addr%/}/v1/${path}")"

  export NETBIRD_ADMIN_NAME
  NETBIRD_ADMIN_NAME="$(jq -r '.data.data.admin_name // empty' <<<"${response}")"
  export NETBIRD_ADMIN_EMAIL
  NETBIRD_ADMIN_EMAIL="$(jq -r '.data.data.admin_email // empty' <<<"${response}")"
  export NETBIRD_ADMIN_PASSWORD
  NETBIRD_ADMIN_PASSWORD="$(jq -r '.data.data.admin_password // empty' <<<"${response}")"
  export NETBIRD_SETUP_KEY
  NETBIRD_SETUP_KEY="$(jq -r '.data.data.setup_key // empty' <<<"${response}")"
  export NETBIRD_DOMAIN
  NETBIRD_DOMAIN="$(jq -r '.data.data.domain // empty' <<<"${response}")"

  [[ -n "${NETBIRD_SETUP_KEY}" && -n "${NETBIRD_DOMAIN}" ]]
}

load_from_local_state() {
  if [[ ! -f "${STATE_FILE}" ]]; then
    return 1
  fi

  export NETBIRD_ADMIN_NAME
  NETBIRD_ADMIN_NAME="$(grep '^NETBIRD_ADMIN_NAME=' "${STATE_FILE}" | cut -d= -f2-)"
  export NETBIRD_ADMIN_EMAIL
  NETBIRD_ADMIN_EMAIL="$(grep '^NETBIRD_ADMIN_EMAIL=' "${STATE_FILE}" | cut -d= -f2-)"
  export NETBIRD_ADMIN_PASSWORD
  NETBIRD_ADMIN_PASSWORD="$(grep '^NETBIRD_ADMIN_PASSWORD=' "${STATE_FILE}" | cut -d= -f2-)"
  export NETBIRD_SETUP_KEY
  NETBIRD_SETUP_KEY="$(grep '^NETBIRD_SETUP_KEY=' "${STATE_FILE}" | cut -d= -f2-)"
  export NETBIRD_DOMAIN
  NETBIRD_DOMAIN="$(grep '^NETBIRD_DOMAIN=' "${STATE_FILE}" | cut -d= -f2-)"

  [[ -n "${NETBIRD_SETUP_KEY}" && -n "${NETBIRD_DOMAIN}" ]]
}

if ! load_from_openbao; then
  load_from_local_state || {
    cat >&2 <<'EOF'
Unable to load NetBird secrets.

Preferred:
  export OPENBAO_ADDR="https://10.100.33.16:8200"
  export OPENBAO_TOKEN="..."
  export OPENBAO_SKIP_VERIFY=true

Fallback:
  create / update .state/netbird-admin.env with the required keys
EOF
    exit 1
  }
fi
