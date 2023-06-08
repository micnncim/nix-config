{ stdenv, fetchurl, ... }:

let
  version = "2.3.0";
  platform = stdenv.hostPlatform;
  archive =
    if platform.isLinux then
      {
        url = "https://downloads.slack-edge.com/slack-cli/slack_cli_${version}_linux_64-bit.tar.gz";
        # sha256 is calculated by `nix-prefetch-url https://downloads.slack-edge.com/slack-cli/slack_cli_${version}_linux_64-bit.tar.gz`.
        sha256 = "056w3mm3kafni0hqglas9aanqzfyhskdnnw5wx59q0ibj2psiqpd";
      }
    else if platform.isDarwin then
      {
        url = "https://downloads.slack-edge.com/slack-cli/slack_cli_${version}_macOS_64-bit.tar.gz";
        # sha256 is calculated by `nix-prefetch-url https://downloads.slack-edge.com/slack-cli/slack_cli_${version}_macOS_64-bit.tar.gz`.
        sha256 = "0vpl57jhf41w9f1pfv57xmiwrg7grkgakch22n6ka5m1snv0bdd9";
      }
    else throw "Unsupported platform ${platform}";
in
stdenv.mkDerivation rec {
  pname = "slack-cli";
  inherit version;

  src = fetchurl {
    inherit (archive) url sha256;
  };

  installPhase = ''
    mkdir -p $out/bin
    cp slack $out/bin/slack
  '';
}
