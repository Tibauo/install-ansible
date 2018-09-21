createcontainer:
	@echo "Create Container"
	docker build . -t test-ansible

test: createcontainer 
	@echo "Execute test"
	./testansible.sh
