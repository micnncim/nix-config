{ config, lib, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      monaspace
      unstable.nerd-fonts.monaspace
    ];
  };
}
