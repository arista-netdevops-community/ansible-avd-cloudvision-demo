DOCKER_NAME ?= arista/avd-cvp-demo

.PHONY: build
build: ## Build docker image based on latest supported Python version
	docker build -f Dockerfile -t $(DOCKER_NAME):latest .

.PHONY: shell
shell: ## Connect to docker container
	docker run -it --rm -v $(PWD):/project $(DOCKER_NAME):latest sh

.PHONY: 
configure-ztp: ## Connect to docker container
	docker run -it --rm -v $(PWD):/project $(DOCKER_NAME):latest ansible-playbook dc1-ztp-configuration.yml

.PHONY: deploy
deploy: ## Run ansible playbook to deploy EVPN Fabric.
	docker run -it --rm -v $(PWD):/project $(DOCKER_NAME):latest ansible-playbook dc1-fabric-deploy-cvp.yml

.PHONY: reset
reset: ## Run ansible playbook to reset all devices.
	docker run -it --rm -v $(PWD):/project $(DOCKER_NAME):latest ansible-playbook dc1-fabric-reset-cvp.yml

.PHONY: clean
clean: ## Delete previously generated outputs
	sh repository-cleanup.sh


.PHONY: setup-repository
setup-repository: ## Install python requirements
	pip install --upgrade wheel
	pip install -r requirements.txt
	pip install -r .github/requirements.dev.txt