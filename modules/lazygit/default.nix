{ config, lib, pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging.pager = "${pkgs.delta}/bin/delta --dark --paging=never";
      };
    };
  };
}
