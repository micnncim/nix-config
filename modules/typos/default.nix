{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.typos ];

  xdg.configFile."typos/typos.toml".source = ./typos.toml;
}
