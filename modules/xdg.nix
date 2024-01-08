{ config, lib, pkgs, ... }:

{
  xdg = {
    enable = true;
    configFile = {
      "bat/.batrc".source = ./.batrc;
      "dircolors/.dircolors".source = ./.dircolors;
      "fd/ignore".source = ./fdignore;
      "karabiner/karabiner.json".source = ./karabiner.json;
      "pre-commit/.pre-commit-config.yaml".source = ./.pre-commit-config.yaml;
      "ripgrep/.ripgreprc".source = ./.ripgreprc;
      "starship/starship.toml".source = ./starship.toml;
    };
  };
}
