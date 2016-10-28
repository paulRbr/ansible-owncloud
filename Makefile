run: ## Run a playbook. E.g. make run playbook=setup
	ansible-playbook $(playbook).yml

install: ## Install roles dependencies
	ansible-galaxy install --roles-path vendor/ -r requirements.yml

debug: ## Debug a host's variable. E.g. debug host=myhost
	ansible -m debug -a "var=hostvars[inventory_hostname]" -i hosts $(host)

list: ## List hosts inventory
	cat hosts

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

.PHONY: install
