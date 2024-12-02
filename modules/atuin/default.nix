{ config, lib, pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    settings = {
      update_check = false;
      enter_accept = false;
      show_help = false;
    };
  };
}
