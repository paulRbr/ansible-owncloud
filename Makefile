playbook  ?= setup
inventory ?= hosts
opts      ?= $(args) --vault-password-file=pass-$(inventory).sh

install: ## make install # Install roles dependencies
	ansible-galaxy install --roles-path vendor/ -r requirements.yml

lint: ## make lint playbook=setup # Check syntax of a playbook
	ansible-playbook -i $(inventory) --syntax-check $(opts) $(playbook).yml

debug: mandatory-host-param ## make debug host=myhost # Debug a host's variable
	ansible -i $(inventory) $(opts) -m debug -a "var=hostvars[inventory_hostname]" $(host)

dry-run: ## make dry-run playbook=setup # Run a playbook in dry run mode
	ansible-playbook -i $(inventory) --diff --check $(opts) $(playbook).yml

run: ## make run playbook=setup # Run a playbook
	ansible-playbook -i $(inventory) --diff $(opts) $(playbook).yml

list: ## make list # List hosts inventory
	[ -f $(inventory) ] && cat $(inventory) || \
	[ -f $(inventory)/hosts ] && cat $(inventory)/hosts

vault: mandatory-file-param ## make vault file=/tmp/vault.yml # Edit or create a vaulted file
	[ -f $(file) ] && ansible-vault $(opts) edit $(file) || \
	ansible-vault $(opts) create $(file)

console: ## make console # Run an ansible console
	ansible-console -i $(inventory) $(opts)

mandatory-host-param:
	[ ! -z $(host) ]
mandatory-file-param:
	[ ! -z $(file) ]

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

.PHONY: install lint run dry-run debug list vault console mandatory-host-param mandatory-file-param
