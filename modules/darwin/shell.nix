{ config, lib, pkgs, username, ... }:

{
  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.fish;
  };

  environment = { loginShell = "/etc/profiles/per-user/${username}/bin/fish"; };
}
