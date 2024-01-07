{ config, pkgs, lib, username, ... }:

{
  imports = [
    ./darwin/font.nix
    ./darwin/gnupg.nix
    ./darwin/homebrew.nix
    ./darwin/nix.nix
    ./darwin/shell.nix
    ./darwin/system.nix
  ];
}
