{ config, lib, pkgs, ... }:

{
  xdg = {
    enable = true;
    configFile = {
      "fd/ignore".source = ./fdignore;
      "karabiner/karabiner.json".source = ./karabiner.json;
      "pre-commit/.pre-commit-config.yaml".source = ./.pre-commit-config.yaml;
      "sketchybar" = {
        source = ./sketchybar;
        recursive = true;
      };
    };
  };
}
