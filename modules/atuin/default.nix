{ config, lib, pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    settings = {
      update_check = false;
      enter_accept = false;
      show_help = false;
    };
  };
}
