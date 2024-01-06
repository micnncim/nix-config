{ config, lib, pkgs, ... }:

{
  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-dash
      nur.repos.micnncim.gh-sync
    ];
    settings = {
      aliases = {
        b = "!gh browse -b $(git rev-parse --abbrev-ref HEAD)";
      };
    };
  };
}
