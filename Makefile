CONTAINER ?= avdteam/base:3.6
HOME_DIR = $(shell pwd)

help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

################################################################################
# AVD Commands
################################################################################

.PHONY: build
build: ## Run ansible playbook to build EVPN Fabric configuration.
	ansible-playbook playbooks/dc1-fabric-deploy-cvp.yml --tags build

.PHONY: provision
provision: ## Run ansible playbook to deploy EVPN Fabric.
	ansible-playbook playbooks/dc1-fabric-deploy-cvp.yml --tags provision

.PHONY: deploy
deploy: ## Run ansible playbook to deploy EVPN Fabric.
	ansible-playbook playbooks/dc1-fabric-deploy-cvp.yml --extra-vars "execute_tasks=true" --tags "build,provision,apply"

.PHONY: reset
reset: ## Run ansible playbook to reset all devices.
	ansible-playbook playbooks/dc1-fabric-reset-cvp.yml

.PHONY: ztp
ztp: ## Configure ZTP server
	ansible-playbook playbooks/dc1-ztp-configuration.yml

.PHONY: configlet-upload
configlet-upload: ## Upload configlets available in configlets/ to CVP.
	ansible-playbook playbooks/dc1-upload-configlets.yml

.PHONY: install
install: ## Install Ansible collections
	git clone https://github.com/aristanetworks/ansible-avd.git
	git clone https://github.com/aristanetworks/ansible-cvp.git
	pip3 install -r requirements.txt

.PHONY: uninstall
uninstall: ## Remove collection from ansible
	rm -rf ansible-avd
	rm -rf ansible-cvp

.PHONY: webdoc
webdoc: ## Build documentation to publish static content
	mkdocs build -f mkdocs.yml

.PHONY: shell
shell: ## Start docker to get a preconfigured shell
	docker pull $(CONTAINER) && \
	docker run --rm -it \
		-v $(HOME_DIR)/:/projects \
		-v /etc/hosts:/etc/hosts $(CONTAINER)