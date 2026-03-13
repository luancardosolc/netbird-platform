#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OPENBAO_STATE="${ROOT_DIR}/../openbao-platform/infra/tofu/terraform.tfstate"

if [[ ! -f "${OPENBAO_STATE}" ]]; then
  echo "openbao-platform state not found at ${OPENBAO_STATE}" >&2
  exit 1
fi

export PLATFORM_HETZNER_TOKEN="${PLATFORM_HETZNER_TOKEN:-}"
export NETBIRD_SERVER_IP="${NETBIRD_SERVER_IP:-$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["outputs"]["server_public_ip"]["value"])' "${OPENBAO_STATE}")}"
export NETBIRD_DOMAIN="${NETBIRD_DOMAIN:-${NETBIRD_SERVER_IP}.sslip.io}"
export NETBIRD_EXISTING_SERVER_NAME="${NETBIRD_EXISTING_SERVER_NAME:-$(python3 -c 'import json,sys; data=json.load(open(sys.argv[1])); print([r["instances"][0]["attributes"]["name"] for r in data["resources"] if r.get("type")=="hcloud_server"][0])' "${OPENBAO_STATE}")}"
export NETBIRD_EXISTING_FIREWALL_NAME="${NETBIRD_EXISTING_FIREWALL_NAME:-$(python3 -c 'import json,sys; data=json.load(open(sys.argv[1])); print([r["instances"][0]["attributes"]["name"] for r in data["resources"] if r.get("type")=="hcloud_firewall"][0])' "${OPENBAO_STATE}")}"
export NETBIRD_EXISTING_FIREWALL_ID="${NETBIRD_EXISTING_FIREWALL_ID:-$(python3 -c 'import json,sys; data=json.load(open(sys.argv[1])); print([r["instances"][0]["attributes"]["id"] for r in data["resources"] if r.get("type")=="hcloud_firewall"][0])' "${OPENBAO_STATE}")}"

if [[ -z "${PLATFORM_HETZNER_TOKEN}" ]]; then
  echo "PLATFORM_HETZNER_TOKEN must be set" >&2
  exit 1
fi

cd "${ROOT_DIR}/infra/tofu"
export TF_VAR_hetzner_token="${PLATFORM_HETZNER_TOKEN}"
export TF_VAR_existing_server_name="${NETBIRD_EXISTING_SERVER_NAME}"
export TF_VAR_existing_firewall_name="${NETBIRD_EXISTING_FIREWALL_NAME}"
export TF_VAR_netbird_domain="${NETBIRD_DOMAIN}"
tofu init
tofu validate
if ! tofu state show hcloud_firewall.shared >/dev/null 2>&1; then
  tofu import hcloud_firewall.shared "${NETBIRD_EXISTING_FIREWALL_ID}"
fi
tofu apply -auto-approve

cd "${ROOT_DIR}"
ansible-playbook -i infra/tofu/inventory.ini infra/ansible/playbooks/install-netbird.yml
