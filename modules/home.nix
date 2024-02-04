{ config, lib, pkgs, username, ... }:

{
  imports = [
    ./pkgs.nix
    ./shell.nix

    ./alacritty.nix
    ./atuin.nix
    ./bash.nix
    ./bat.nix
    ./direnv.nix
    ./fd.nix
    ./fish.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./go.nix
    ./gpg.nix
    ./karabiner.nix
    ./neovim.nix
    ./nix-index.nix
    ./pre-commit.nix
    ./ripgrep.nix
    ./sketchybar.nix
    ./ssh.nix
    ./starship.nix
    ./tealdeer.nix
    ./tmux.nix
    ./typos.nix
    ./xcode.nix
  ];

  home.stateVersion = "22.11";

  home.homeDirectory = "/Users/${username}";

  programs.home-manager.enable = true;
}
