{ config, pkgs, lib, username, ... }:

{
  imports = [
    ./darwin/pam.nix

    ./darwin/font.nix
    ./darwin/gnupg.nix
    ./darwin/homebrew.nix
    ./darwin/nix.nix
    ./darwin/security.nix
    ./darwin/shell.nix
    ./darwin/system.nix
  ];
}
