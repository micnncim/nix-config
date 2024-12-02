{ config, lib, pkgs, username, ... }:

{
  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  environment.variables = {
    EDITOR = "nvim";
    PAGER = "less";
  };

  environment.shells = with pkgs;[
    bashInteractive
    fish
  ];
}
