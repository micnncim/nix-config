{ config, lib, pkgs, ... }:

{
  programs.man = {
    enable = true;
    generateCaches = true;
  };
}
