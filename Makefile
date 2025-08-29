VERSION=$(shell git describe --tags --always)

.PHONY: image
# build backend image
image:
	docker build -f Dockerfile --network host -t ghcr.io/openhdc/ghcr-test:$(VERSION) .