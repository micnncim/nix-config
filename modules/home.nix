{ config, lib, pkgs, username, ... }:

{
  imports = [
    ./bash.nix
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./gh.nix
    ./gpg.nix
    ./neovim.nix
    ./nix-index.nix
    ./pkgs.nix
    ./shell.nix
    ./tmux.nix
    ./xdg.nix
  ];

  home.stateVersion = "22.11";

  home.homeDirectory = "/Users/${username}";

  programs.home-manager.enable = true;
}
