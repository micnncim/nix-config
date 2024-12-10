{ config, lib, pkgs, ... }:

lib.mkIf pkgs.stdenv.isDarwin {
  home.file."${config.home.homeDirectory}/.hammerspoon" = {
    source = ./hammerspoon;
    recursive = true;
  };
}
