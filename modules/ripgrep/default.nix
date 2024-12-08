{ config, lib, pkgs, ... }:

{
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--max-columns=500"
      "--max-columns-preview"
      "--smart-case"
      "--hidden"

      # Catppuccin Mocha
      "--colors=path:fg:180,190,254" # Lavender
      "--colors=line:fg:166,227,161" # Green
      "--colors=match:fg:250,179,135" # Peach
      "--colors=match:style:bold"

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
