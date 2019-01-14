test-unit:
	@echo "Start test"
	tar -cvzf install.tar.gz install
	mv install.tar.gz test
	cd test && make test

clean:
	@echo "Start clean" 
	docker rm $$(docker ps -a -q) -f 
	docker rmi $$(docker images -a -q) -f
	rm test/install.tar.gz
