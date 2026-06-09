INVENTORY ?= inventories/local.ini
PLAYBOOK ?= playbooks/site.yml
ANSIBLE ?= ansible-playbook

.PHONY: help deps local-up deploy local-deploy smoke destroy destroy-data remote-example

help:
	@echo "Cloud-1 helper targets"
	@echo "  make local-up       Start local Ubuntu VM with Vagrant"
	@echo "  make deploy         Run Ansible against INVENTORY=$(INVENTORY)"
	@echo "  make local-deploy   Start local VM then deploy the stack"
	@echo "  make smoke          Smoke-test local forwarded ports"
	@echo "  make destroy        Stop containers on target, keep volumes/data"
	@echo "  make destroy-data   Stop containers and delete /opt/cloud-1 data"
	@echo "  make remote-example Show the command for a real VPS inventory"

deps:
	ansible-galaxy collection install -r requirements.yml

local-up:
	vagrant up

deploy: deps
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK)

local-deploy: local-up deploy
	@echo "WordPress:   https://cloud1.localhost:8443"
	@echo "phpMyAdmin: https://pma.cloud1.localhost:8443"
	@echo "If your browser cannot resolve those names, add this to /etc/hosts:"
	@echo "127.0.0.1 cloud1.localhost pma.cloud1.localhost"

smoke:
	./scripts/smoke-test.sh

destroy:
	$(ANSIBLE) -i $(INVENTORY) playbooks/destroy.yml

destroy-data:
	$(ANSIBLE) -i $(INVENTORY) playbooks/destroy.yml -e cloud1_delete_data=true

remote-example:
	@echo "cp inventories/production.ini.example inventories/production.ini"
	@echo "# Edit IP/user/key, then:"
	@echo "make deploy INVENTORY=inventories/production.ini"
