{ config, lib, pkgs, ... }:

{
  xdg = {
    enable = true;
    configFile = {
      "sketchybar" = {
        source = ./sketchybar;
        recursive = true;
      };
    };
  };
}
