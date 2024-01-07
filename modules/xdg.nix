{ config, lib, pkgs, ... }:

{
  xdg = {
    enable = true;
    configFile = {
      # "alacritty/alacritty.yml".source = ./alacritty.yml;
      "alacritty" = {
        recursive = true;
        source = ./alacritty;
      };
      "bat/.batrc".source = ./.batrc;
      "dircolors/.dircolors".source = ./.dircolors;
      "fd/ignore".source = ./fdignore;
      "git" = {
        recursive = true;
        source = ./git;
      };
      "git/templates/hooks".source =
        config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/git/hooks";
      "karabiner/karabiner.json".source = ./karabiner.json;
      "pre-commit/.pre-commit-config.yaml".source = ./.pre-commit-config.yaml;
      "ripgrep/.ripgreprc".source = ./.ripgreprc;
      "starship/starship.toml".source = ./starship.toml;
    };
  };
}
