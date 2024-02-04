{ config, pkgs, lib, username, ... }:

{
  imports = [
    ./pam.nix

    ./fonts.nix
    ./gnupg.nix
    ./homebrew.nix
    ./nix.nix
    ./security.nix
    ./shell.nix
    ./sketchybar.nix
    ./skhd.nix
    ./ssh.nix
    ./system.nix
    ./yabai.nix
  ];
}
