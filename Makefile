DOCKER_NAME ?= arista/avd-cvp-demo

help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

################################################################################
# AVD Commands
################################################################################

.PHONY: build
avd-build: ## Run ansible playbook to build EVPN Fabric configuration.
	ansible-playbook dc1-fabric-deploy-cvp.yml --tags build

.PHONY: rovision
avd-provision: ## Run ansible playbook to deploy EVPN Fabric.
	ansible-playbook dc1-fabric-deploy-cvp.yml --tags provision

.PHONY: deploy
avd-deploy: ## Run ansible playbook to deploy EVPN Fabric.
	ansible-playbook dc1-fabric-deploy-cvp.yml --extra-vars "execute_tasks=true" --tags "build,provision,apply"

.PHONY: reset
avd-reset: ## Run ansible playbook to reset all devices.
	ansible-playbook dc1-fabric-reset-cvp.yml

.PHONY: clean
clean: ## Delete previously generated outputs
	sh repository-cleanup.sh

.PHONY: ztp
ztp: ## Configure ZTP server
	ansible-playbook dc1-ztp-configuration.yml

# .PHONY: install
# install: ## Install Ansible collections
# 	ansible-galaxy collection install arista.cvp -p ansible-cvp
# 	ansible-galaxy collection install arista.avd -p ansible-avd

.PHONY: install
install: ## Install Ansible collections
	git clone https://github.com/aristanetworks/ansible-avd.git
	git clone https://github.com/aristanetworks/ansible-cvp.git

.PHONY: uninstall
uninstall: ## Remove collection from ansible
	rm -rf ansible-avd
	rm -rf ansible-cvp

.PHONY: install-requirements
install-requirements: ## Install python requirements
	pip install --upgrade wheel
	pip install -r requirements.txt

.PHONY: install-requirements-dev
install-requirements-dev: ## Install python requirements
	pip install --upgrade wheel
	pip install -r requirements.txt
	pip install -r .github/requirements.dev.txt

.PHONY: linting
linting: ## Run pre-commit script for python code linting using pylint
	sh .github/lint-yaml.sh