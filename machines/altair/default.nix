{ config, lib, pkgs, username, ... }:

{
  ids.uids.nixbld = 300;
  ids.gids.nixbld = 30000;

  home-manager.users.${username} = { pkgs, ... }: {
    programs.lazygit = {
      settings = {
        git = {
          branchPrefix = "micnncim/";
        };
      };
    };
  };

  homebrew = {
    casks = [
      "google-chrome"
      "tailscale"
    ];
  };
}
