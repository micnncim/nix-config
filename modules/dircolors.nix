{ config, lib, pkgs, ... }:

{
  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ./.dircolors;
  };
}
