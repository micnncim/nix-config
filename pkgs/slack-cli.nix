{ stdenv, fetchurl, ... }:

let
  version = "2.2.0";
  platform = stdenv.hostPlatform;
  archive =
    if platform.isLinux then
      {
        url = "https://downloads.slack-edge.com/slack-cli/slack_cli_${version}_linux_64-bit.tar.gz";
        # sha256 is calculated by `nix-prefetch-url https://downloads.slack-edge.com/slack-cli/slack_cli_${version}_linux_64-bit.tar.gz`.
        sha256 = "00752ww7ngphr1xlsw5blgbhfqgc4kn512dsjx6xrmbbfqbzszd6";
      }
    else if platform.isDarwin then
      {
        url = "https://downloads.slack-edge.com/slack-cli/slack_cli_${version}_macOS_64-bit.tar.gz";
        # sha256 is calculated by `nix-prefetch-url https://downloads.slack-edge.com/slack-cli/slack_cli_${version}_macOS_64-bit.tar.gz`.
        sha256 = "097m36w5qhkghygb4bhn8v8whhmhwmzd1a79nq7dxh9y3rwjlihr";
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
