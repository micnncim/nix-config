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
      "alt-tab"
      "ankerwork"
      "copilot-for-xcode"
      "coscreen"
      "cursor"
      "discord"
      "docker"
      "figma"
      "google-chrome"
      "google-drive"
      "google-japanese-ime"
      "imageoptim"
      "karabiner-elements"
      "keyboardcleantool"
      "muzzle"
      "notion-calendar"
      "notion"
      "raycast"
      "sf-symbols"
      "slack"
      "spotify"
      "stats"
      "tailscale"
      "todoist"
      "visual-studio-code"
      "vivaldi"
      "zoom"
    ];
    masApps = {
      "Get Plain Text" = 508368068;
      Spark = 1176895641;
    };
  };
}
