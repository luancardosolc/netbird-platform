#!/usr/bin/env bash
set -euo pipefail

SERVICE_NAME="${OPENBAO_TOKEN_SERVICE_NAME:-openbao-netbird-read-token}"
ACCOUNT_NAME="${OPENBAO_TOKEN_ACCOUNT:-${USER}}"
TOKEN_VALUE="${1:-${OPENBAO_SCOPED_TOKEN:-${OPENBAO_TOKEN:-}}}"

if [[ -z "${TOKEN_VALUE}" ]]; then
  echo "Provide the scoped OpenBao token as the first argument or via OPENBAO_SCOPED_TOKEN." >&2
  exit 1
fi

if ! command -v security >/dev/null 2>&1; then
  echo "The macOS security CLI is required to store the token in Keychain." >&2
  exit 1
fi

security add-generic-password \
  -U \
  -a "${ACCOUNT_NAME}" \
  -s "${SERVICE_NAME}" \
  -w "${TOKEN_VALUE}" >/dev/null

echo "Stored scoped OpenBao token in macOS Keychain service ${SERVICE_NAME}."
