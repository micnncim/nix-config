{ config, lib, pkgs, ... }:

{
  xdg = {
    enable = true;
    configFile = {
      "fd/ignore".source = ./fdignore;
      "karabiner/karabiner.json".source = ./karabiner.json;
      "pre-commit/.pre-commit-config.yaml".source = ./.pre-commit-config.yaml;
      "ripgrep/.ripgreprc".source = ./.ripgreprc;
      "sketchybar" = {
        source = ./sketchybar;
        recursive = true;
      };
      "starship/starship.toml".source = ./starship.toml;
    };
  };
}
