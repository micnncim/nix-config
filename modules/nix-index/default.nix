{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];

  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
}
