UNAME := $(shell uname)
DOCKER_IMAGE := $(shell whoami)/sw-lsst-eu

.PHONY: all

all:
	@echo "Usage: make <pkg | test | clean>"


pkg:
ifeq ($(UNAME), Linux)
	docker build --tag $(DOCKER_IMAGE) .
	docker run -it --rm --mount type=bind,source=$(shell pwd),destination=/scratch --env SCRATCH=/scratch $(DOCKER_IMAGE)
else
	bash package-for-macos.sh
endif


test:
ifeq ($(UNAME), Linux)
	docker run -it --rm --entrypoint /bin/bash $(DOCKER_IMAGE)
endif


clean:
	@rm -f ./*.deb ./*.rpm ./*.pkg
