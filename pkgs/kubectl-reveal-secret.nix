{ lib, stdenv, fetchFromGitHub, ... }:

with lib;
let sources = import ../nix/sources.nix;
in
stdenv.mkDerivation rec {
  pname = "kubectl-reveal-secret";
  version = sources.kubectl-reveal-secret.branch;

  src = fetchFromGitHub { inherit (sources.kubectl-reveal-secret) owner repo rev sha256; };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    install $src/kubectl-reveal-secret $out/bin
  '';
}
