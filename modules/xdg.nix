{ config, lib, pkgs, ... }:

{
  xdg = {
    enable = true;
    configFile = {
      "fd/ignore".source = ./fdignore;
      "karabiner/karabiner.json".source = ./karabiner.json;
      "sketchybar" = {
        source = ./sketchybar;
        recursive = true;
      };
    };
  };
}
