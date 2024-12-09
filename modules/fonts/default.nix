{ config, lib, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    monaspace
    unstable.nerd-fonts.monaspace
  ];
}
