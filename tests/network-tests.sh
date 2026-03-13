#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

grep -q '10.100.0.0/16' "${ROOT_DIR}/docs/network-design.md"
grep -q '3478' "${ROOT_DIR}/infra/ansible/playbooks/install-netbird.yml"
grep -q '8200' "${ROOT_DIR}/infra/ansible/playbooks/install-netbird.yml"
