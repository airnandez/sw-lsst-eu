.PHONY: all

all: run

run: pkgs
	docker build -t airnandez/sw-lsst-eu-centos-test .
	docker run -it airnandez/sw-lsst-eu-centos-test

pkgs:
	@cp ../../*.rpm .