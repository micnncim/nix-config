{ config, lib, pkgs, ... }:

let
  homeDir = config.home.homeDirectory;
in
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      whitelist = {
        prefix = [
          "${homeDir}/src/github.com/micnncim"
          "${homeDir}/src/github.com/ergastirio"
          "${homeDir}/src/github.com/ergastirio-labs"
          "${homeDir}/src/github.com/kouzoh"
        ];
      };
    };
  };
}
