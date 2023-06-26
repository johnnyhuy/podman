
VERSION := $(shell git describe --tags --always --dirty)

run:
	podman run \
		--rm \
		-it \
		ghcr.io/johnnyhuy/podman/$(NAME):$(VERSION) \
		/bin/bash

run-fedora:
	$(MAKE) run NAME=fedora

run-ubuntu:
	$(MAKE) run NAME=ubuntu

build:
	podman build \
		--platform linux/amd64 \
		-t ghcr.io/johnnyhuy/podman/$(NAME):$(VERSION) \
		-f Containerfile \
		$(NAME)/

build-fedora:
	$(MAKE) build NAME=fedora

build-ubuntu:
	$(MAKE) build NAME=ubuntu

push:
	podman push ghcr.io/johnnyhuy/podman/$(NAME):$(VERSION)

publish:
	$(MAKE) build NAME=fedora
	$(MAKE) push NAME=fedora

	$(MAKE) build NAME=ubuntu
	$(MAKE) push NAME=ubuntu
	
