{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.ghq ];

  programs.git.extraConfig = {
    ghq.root = "${config.home.homeDirectory}/src";
  };
}
