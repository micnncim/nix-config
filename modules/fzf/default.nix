{ config, lib, pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    defaultOptions = [ "--reverse" "--height 40%" "--multi" "--cycle" ];
    # Nord theme
    # Ref: https://github.com/ianchesal/nord-fzf
    colors = {
      "fg" = "#e5e9f0";
      "bg" = "#2e3440";
      "hl" = "#81a1c1";
      "fg+" = "#e5e9f0";
      "bg+" = "#2e3440";
      "hl+" = "#81a1c1";
      "info" = "#eacb8a";
      "prompt" = "#bf6069";
      "pointer" = "#b48dac";
      "marker" = "#a3be8b";
      "spinner" = "#b48dac";
      "header" = "#a3be8b";
    };
  };
}
