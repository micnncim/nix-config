{ lib, stdenv, fetchFromGitHub, ... }:

with lib;
let sources = import ../nix/sources.nix;
in stdenv.mkDerivation rec {
  pname = "gctx";
  version = sources.gctx.branch;

  src = fetchFromGitHub { inherit (sources.gctx) owner repo rev sha256; };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    install $src/gctx $out/bin
  '';
}
