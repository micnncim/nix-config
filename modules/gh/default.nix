{ config, lib, pkgs, ... }:

{
  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-actions-cache
      gh-dash
      unstable.gh-copilot
      nur.repos.micnncim.gh-pr-status
      nur.repos.micnncim.gh-sync
    ];
    settings = {
      git_protocol = "ssh";
    };
  };
}
