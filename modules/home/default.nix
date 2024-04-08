{ config, lib, pkgs, username, ... }:

{
  imports = [
    ../pkgs
    ../shell

    ../alacritty
    ../atuin
    ../bash
    ../bat
    ../direnv
    ../editorconfig
    ../fd
    ../fish
    ../fzf
    ../gh
    ../ghq
    ../git
    ../go
    ../gpg
    ../karabiner
    ../neovim
    ../nix-index
    ../pre-commit
    ../ripgrep
    ../sketchybar
    ../ssh
    ../starship
    ../tealdeer
    ../tmux
    ../typos
    ../xcode
  ];

  home.stateVersion = "22.11";

  home.homeDirectory = "/Users/${username}";

  programs.home-manager.enable = true;
}
