{ config, lib, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig =
      # https://developer.1password.com/docs/ssh
      lib.mkIf pkgs.stdenv.isDarwin ''
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
      '';
  };
}
