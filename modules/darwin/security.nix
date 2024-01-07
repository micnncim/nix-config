{ config, lib, pkgs, ... }:

{
  security = {
    pam = {
      enableSudoTouchIdAuth = true;
      enableSudoWatchIdAuth = true;
    };
  };
}
