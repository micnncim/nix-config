OUT := result

CACHIX_CACHE ?= micnncim-nix-config

HOSTNAME ?= $(shell hostname)
NIX_NAME ?= darwinConfigurations.$(HOSTNAME).system

.DEFAULT_GOAL := install

.PHONY: install
install: build switch

.PHONY: build
build:
	@nix build ".#$(NIX_NAME)" --json \
		| jq -r '.[].outputs | to_entries[].value' \
		| cachix push "$(CACHIX_CACHE)"

.PHONY: build/no-cache
build/no-cache:
	@nix build ".#$(NIX_NAME)"

.PHONY: switch
switch: $(OUT)/sw/bin/darwin-rebuild
	@$(OUT)/sw/bin/darwin-rebuild switch --flake "."
