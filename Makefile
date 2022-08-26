OUT := result

CACHIX_CACHE ?= micnncim-nix-config

.PHONY: build
build:
	@nix build "$(HOME)/.config/nixpkgs#darwinConfigurations.$(shell hostname).system" --json \
		| jq -r '.[].outputs | to_entries[].value' \
		| cachix push "$(CACHIX_CACHE)"

.PHONY: switch
switch: $(OUT)/sw/bin/darwin-rebuild
	@$(OUT)/sw/bin/darwin-rebuild switch --flake "$(HOME)/.config/nixpkgs"

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
