UNAME := $(shell uname)

.PHONY: all

all:
	@echo "Usage: make <pkg | test | clean>"


pkg:
ifeq ($(UNAME), Linux)
	docker build -t airnandez/sw-lsst-eu .
	docker run -it  --mount type=bind,source=`pwd`,destination=/scratch  --env SCRATCH=/scratch   airnandez/sw-lsst-eu
else
	bash buildMacOSPkg.sh
endif


test:
ifeq ($(UNAME), Linux)
	docker run -it  --entrypoint /bin/bash  airnandez/sw-lsst-eu
endif


clean:
	@rm -f  ./*.deb  ./*.rpm
