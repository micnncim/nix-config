{ config, lib, pkgs, inputs, username, ... }:

{
  imports = [
    ../pkgs
    ../shell

    ../alacritty
    ../atuin
    ../bash
    ../bat
    ../catppuccin
    ../direnv
    ../editorconfig
    ../fd
    ../fonts
    ../fish
    ../fzf
    ../gh
    ../ghq
    ../git
    ../go
    ../gpg
    ../karabiner
    ../lazygit
    ../man
    ../neovim
    ../nix-index
    ../pre-commit
    ../ripgrep
    ../sketchybar
    ../spotify
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
