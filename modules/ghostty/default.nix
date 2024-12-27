{ config, lib, pkgs, ... }:

{
  # TODO(micnncim): Switch to Home Manager after the following PR is merged:
  # Ref: https://github.com/nix-community/home-manager/pull/6235
  xdg.configFile."ghostty/config".source = ./config;
}
