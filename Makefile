CONTAINER ?= ghcr.io/arista-netdevops-community/avd-all-in-one-container/avd-all-in-one
VSCODE_CONTAINER ?= avdteam/vscode:latest
VSCODE_PORT ?= 8080
HOME_DIR = $(shell pwd)
AVD_UID ?= $(shell id -u)
GIT_USERNAME ?= $(shell git config --get user.name)
GIT_EMAIL ?= $(shell git config --get user.email)
AVD_COLLECTION_VERSION ?= 3.8.4
CVP_COLLECTION_VERSION ?= 3.6.0
COLLECTION_PATH = $(shell ansible-galaxy collection list arista.avd --format yaml | sed -n  -e 's/://g' -e '1 p')

help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

################################################################################
# AVD Commands
################################################################################

.PHONY: build
build: ## Run ansible playbook to build EVPN Fabric configuration.
	ansible-playbook playbooks/dc1-fabric-deploy-cvp.yml --tags build ${OPTIONS}

.PHONY: build-act
build-act: ## Run ansible playbook to build EVPN Fabric configuration when following ACT User guide
	ansible-playbook playbooks/dc1-fabric-deploy-cvp.yml --tags build -i inventory/inventory.yml -i inventory/AVD-test.yml

.PHONY: provision
provision: ## Run ansible playbook to deploy EVPN Fabric.
	ansible-playbook playbooks/dc1-fabric-deploy-cvp.yml --tags provision ${OPTIONS}

.PHONY: provision-act
provision-act: ## Run ansible playbook to deploy EVPN Fabric when following ACT User guide.
	ansible-playbook playbooks/dc1-fabric-deploy-cvp.yml --tags provision -i inventory/inventory.yml -i inventory/AVD-test.yml

.PHONY: deploy
deploy: ## Run ansible playbook to deploy EVPN Fabric.
	ansible-playbook playbooks/dc1-fabric-deploy-cvp.yml --extra-vars "execute_tasks=true" --tags "build,provision,apply"

.PHONY: validate
validate: ## Run ansible playbook to validate EVPN Fabric.
	ansible-playbook playbooks/dc1-fabric-validate.yml $(OPTIONS)

.PHONY: validate-act
validate-act: ## Run ansible playbook to validate EVPN Fabric when following ACT User guide.
	ansible-playbook playbooks/dc1-fabric-validate.yml  -i inventory/inventory.yml -i inventory/AVD-test.yml

.PHONY: reset
reset: ## Run ansible playbook to reset all devices.
	ansible-playbook playbooks/dc1-fabric-reset-cvp.yml

.PHONY: ztp
ztp: ## Configure ZTP server
	ansible-playbook playbooks/dc1-ztp-configuration.yml

.PHONY: configlet-upload
configlet-upload: ## Upload configlets available in configlets/ to CVP.
	ansible-playbook playbooks/dc1-upload-configlets.yml

.PHONY: install-git
install-git: ## Install Ansible collections from git
	git clone --depth 1 --branch v$(AVD_COLLECTION_VERSION) https://github.com/aristanetworks/ansible-avd.git
	git clone --depth 1 --branch v$(CVP_COLLECTION_VERSION) https://github.com/aristanetworks/ansible-cvp.git
	pip3 install -r ansible-avd/development/requirements.txt

.PHONY: install
install: ## Install Ansible collections
	ansible-galaxy collection install arista.avd:==${AVD_COLLECTION_VERSION}
	ansible-galaxy collection install arista.cvp:==${CVP_COLLECTION_VERSION}
	pip3 install -r ${COLLECTION_PATH}/arista/avd/requirements.txt

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
		-e AVD_GIT_USER="$(GIT_USERNAME)" \
		-e AVD_GIT_EMAIL="$(GIT_EMAIL)" \
		-v $(HOME_DIR)/:/home/avd/projects/ \
		-v /etc/hosts:/etc/hosts $(CONTAINER)

.PHONY: vscode
vscode: ## Run a vscode server on port 8080
	docker run --rm -it -d \
		-e AVD_GIT_USER="$(git config --get user.name)" \
		-e AVD_GIT_EMAIL="$(git config --get user.email)" \
		-v $(HOME_DIR):/home/avd/ansible-avd-cloudvision-demo \
		-p $(VSCODE_PORT):8080 $(VSCODE_CONTAINER)
	@echo "---------------"
	@echo "VScode for AVD: http://127.0.0.1:$(VSCODE_PORT)/?folder=/home/avd/ansible-avd-cloudvision-demo"
