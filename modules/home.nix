{ config, lib, pkgs, username, ... }:

{
  imports = [
    ./pkgs.nix
    ./shell.nix
    ./xdg.nix

    ./alacritty.nix
    ./bash.nix
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./neovim.nix
    ./nix-index.nix
    ./tealdeer.nix
    ./tmux.nix
    ./xcode.nix
  ];

  home.stateVersion = "22.11";

  home.homeDirectory = "/Users/${username}";

  programs.home-manager.enable = true;
}
