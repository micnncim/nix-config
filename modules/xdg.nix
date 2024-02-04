{ config, lib, pkgs, ... }:

{
  xdg = {
    enable = true;
    configFile = {
      "karabiner/karabiner.json".source = ./karabiner.json;
      "sketchybar" = {
        source = ./sketchybar;
        recursive = true;
      };
    };
  };
}
