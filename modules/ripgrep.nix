{ config, lib, pkgs, ... }:

{
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--max-columns=500"
      "--max-columns-preview"
      "--colors=match:fg:green"
      "--smart-case"
      "--hidden"

      "--glob=!**/.git/**"
      "--glob=!**/dist/**"
      "--glob=!**/dist-types/**"
      "--glob=!**/results/**"
      "--glob=!**/target/**"
      "--glob=!**/coverage/**"
      "--glob=!*-lock.json"
      "--glob=!*.lock"
      "--glob=!cue.mod"
      "--glob=!node_modules"
      "--glob=!vendor"
    ];
  };
}
