{ config, lib, pkgs, ... }:

{
  programs.go = {
    enable = true;
    package = pkgs.go;
    goPath = "src/go";
    goBin = "bin";
    goPrivate = [
      "github.com/micnncim"
      "github.com/kouzoh"
    ];
  };
}
