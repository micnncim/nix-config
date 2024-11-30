{ config, lib, pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    defaultOptions = [ "--reverse" "--height 40%" "--multi" "--cycle" ];
  };
}
