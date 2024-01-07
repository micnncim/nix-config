{ config, lib, pkgs, ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      upgrade = true;
      cleanup = "uninstall";
    };
    casks = [
      "1password"
      # As of writing, the CLI requires itself to be installed in /usr/local/bin/op,
      # which is not a place of Nix's installation, as shown as below:
      #
      # > [ERROR] 2022/12/11 20:05:26 connecting to desktop app: You'll need to move
      # > the CLI to /usr/local/bin/op for the 1Password app integration to work. If
      # > you can't move it, you'll need to turn off Connect with 1Password CLI in the
      # > 1Password app.
      #
      # See also https://1password.community/discussion/127950/v2-client-unable-to-connect-to-desktop-app.
      "1password-cli"
      "alt-tab"
      "barrier"
      "bartender"
      "copilot-for-xcode"
      "coscreen"
      "cron"
      "discord"
      "docker"
      "figma"
      "google-chrome"
      "google-drive"
      "google-japanese-ime"
      "karabiner-elements"
      "keyboardcleantool"
      "keycastr"
      "muzzle"
      "notion"
      "raycast"
      "sf-symbols"
      "slack"
      "spotify"
      "stats"
      "tailscale"
      "visual-studio-code"
      "vivaldi"
      "zoom"
    ];
    masApps = {
      Amphetamine = 937984704;
      "Get Plain Text" = 508368068;
      Spark = 1176895641;
    };
  };
}
