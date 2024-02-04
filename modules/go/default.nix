{ config, lib, pkgs, ... }:

{
  programs.go = {
    enable = true;
    goPath = "src/go";
    goBin = "bin";
    goPrivate = [
      "github.com/micnncim"
      "github.com/kouzoh"
    ];
  };
}
