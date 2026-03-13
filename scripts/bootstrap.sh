#!/usr/bin/env bash
set -euo pipefail

for command in tofu ansible-playbook git curl jq; do
  if ! command -v "${command}" >/dev/null 2>&1; then
    echo "missing required command: ${command}" >&2
    exit 1
  fi
done

echo "Bootstrap complete."
