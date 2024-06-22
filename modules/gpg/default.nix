{ config, lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  programs.gpg = {
    enable = true;
    homedir = "${config.home.homeDirectory}/.gnupg";
    scdaemonSettings = { disable-ccid = true; };
  };

  home.packages = with pkgs; [
    # Temporary remove pinentry until it's fixed.
    # Ref: https://github.com/nix-community/home-manager/issues/3864
    # pinentry
  ] ++ lib.optionals isDarwin [
    pinentry_mac
  ];

  home.file."${config.programs.gpg.homedir}/gpg-agent.conf".text =
    lib.mkIf isDarwin ''
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      default-cache-ttl 34560000
      max-cache-ttl 34560000
      log-file /var/log/gpg-agent.log
    '';
}
