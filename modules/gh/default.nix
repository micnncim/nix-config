{ config, lib, pkgs, ... }:

{
  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-dash
      unstable.gh-copilot
      nur.repos.micnncim.gh-sync
    ];
    settings = {
      git_protocol = "ssh";
      aliases = {
        b = "!gh browse -b $(git rev-parse --abbrev-ref HEAD)";
      };
    };
  };
}
