{ config, lib, pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      map-syntax = [
        "*.lock:JSON"
        "*ignore:Git Ignore"
        "Package.resolved:JSON"
      ];
    };
  };
}
