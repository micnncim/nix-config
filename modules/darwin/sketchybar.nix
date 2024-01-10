{ config, lib, pkgs, ... }:

{
  services.sketchybar = {
    enable = true;
    extraPackages = with pkgs; [
      coreutils
      jq
      yabai
    ];
  };
}
