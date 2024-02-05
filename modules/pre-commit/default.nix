{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.pre-commit ];

  xdg.configFile."pre-commit/.pre-commit-config.yaml".source = ./.pre-commit-config.yaml;
}
