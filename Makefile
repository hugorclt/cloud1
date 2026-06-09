INVENTORY ?= inventories/local.ini
PLAYBOOK ?= playbooks/start.yml
ANSIBLE ?= ansible-playbook

deploy: deps
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK)

.PHONY: deploy

destroy:
	$(ANSIBLE) -i $(INVENTORY) playbooks/destroy.yml

destroy-data:
	$(ANSIBLE) -i $(INVENTORY) playbooks/destroy.yml -e cloud1_delete_data=true