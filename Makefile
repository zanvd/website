ZOLA_IMAGE ?= ghcr.io/getzola/zola:v0.23.6
ZOLA = docker run --rm -u $$(id -u):$$(id -g) -v $(CURDIR):/app -w /app

.PHONY: build
build:
	$(ZOLA) $(ZOLA_IMAGE) build --force

.PHONY: serve
serve:
	$(ZOLA) -p 8080:8080 $(ZOLA_IMAGE) serve --interface 0.0.0.0 --port 8080 --base-url http://localhost:8080
