{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    typos
  ];

  xdg.configFile."typos/typos.toml" = {
    source = ./typos.toml;
  };
}
