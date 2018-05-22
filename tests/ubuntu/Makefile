.PHONY: all

all: run

run: pkgs
	docker build -t airnandez/sw-lsst-eu-ubuntu-test .
	docker run -it airnandez/sw-lsst-eu-ubuntu-test

pkgs:
	@cp ../../*.deb .