{ config, pkgs, lib, username, ... }:

{
  imports = [
    ./pam.nix

    ./aerospace.nix
    ./fonts.nix
    ./gnupg.nix
    ./homebrew.nix
    ./nix.nix
    ./security.nix
    ./shell.nix
    ./ssh.nix
    ./system.nix

    # TODO(micnncim): Delete the following once I've migrated to AeroSpace.
    # ./sketchybar.nix
    # ./skhd.nix
    # ./yabai.nix
  ];
}
