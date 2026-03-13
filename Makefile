SHELL := /bin/bash

.PHONY: bootstrap lint test validate deploy destroy enroll-server enroll-macbook

bootstrap:
	./scripts/bootstrap.sh

lint:
	if command -v shellcheck >/dev/null 2>&1; then shellcheck scripts/*.sh tests/*.sh; fi
	if command -v yamllint >/dev/null 2>&1; then yamllint .github/workflows infra/ansible; fi
	if command -v markdownlint-cli2 >/dev/null 2>&1; then markdownlint-cli2 '**/*.md'; fi
	if command -v tflint >/dev/null 2>&1; then (cd infra/tofu && tflint --init && tflint); fi

validate:
	./tests/infra-tests.sh

test:
	./tests/infra-tests.sh
	./tests/network-tests.sh
	./tests/deployment-tests.sh

deploy:
	./scripts/deploy.sh

destroy:
	./scripts/destroy.sh

enroll-server:
	./scripts/enroll-server.sh

enroll-macbook:
	./scripts/enroll-macbook.sh
