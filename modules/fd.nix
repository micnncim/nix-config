{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.fd ];

  xdg.configFile."fd/ignore".source = ./fdignore;
}
