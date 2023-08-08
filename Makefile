OUT := result

CACHIX_CACHE ?= micnncim-nix-config

NIX_NAME ?= "darwinConfigurations.$(shell hostname).system"

.DEFAULT_GOAL := install

.PHONY: install
install: build switch

.PHONY: build
build:
	@nix build ".#$(NIX_NAME)" --json \
		| jq -r '.[].outputs | to_entries[].value' \
		| cachix push "$(CACHIX_CACHE)"

.PHONY: bootstrap
bootstrap:
	@if ! command -v nix > /dev/null && ! command -v nix-env > /dev/null; then \
		curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install; \
	fi
	@if ! command -v cachix > /dev/null; then \
		nix-env -iA cachix -f https://cachix.org/api/v1/install; \
	fi
	@nix build ".#$(NIX_NAME)"

.PHONY: switch
switch: $(OUT)/sw/bin/darwin-rebuild
	@$(OUT)/sw/bin/darwin-rebuild switch --flake "."

.PHONY: fmt
fmt:
	@find . -type f -name '*.nix' -not -path './nix/*' | xargs nixfmt

.PHONY: lint
lint: lint/darwin lint/flake lint/fmt lint/statix

.PHONY: lint/darwin
lint/darwin: $(OUT)/sw/bin/darwin-rebuild
	@$(OUT)/sw/bin/darwin-rebuild check --flake .

.PHONY: lint/flake
lint/flake:
	@nix flake check .

.PHONY: lint/fmt
lint/fmt:
	@find . -type f -name '*.nix' -not -path './nix/*' | xargs nixfmt --check

.PHONY: lint/statix
lint/statix:
	@statix check . -i nix
