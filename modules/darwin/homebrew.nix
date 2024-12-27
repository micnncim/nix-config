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
      "chatgpt"
      "coscreen"
      "cursor"
      "discord"
      "docker"
      "figma"
      "github-copilot-for-xcode"
      "google-chrome"
      "google-drive"
      "google-japanese-ime"
      "hammerspoon"
      "imageoptim"
      "karabiner-elements"
      "keyboardcleantool"
      "muzzle"
      "notion-calendar"
      "notion"
      "raycast"
      "sf-symbols"
      "slack"
      "stats"
      "tailscale"
      "todoist"
      "visual-studio-code"
      "vivaldi"
      "voicevox"
      "zoom"

      # TODO(micnncim): Switch to Nix after the following PR is merged:
      # Ref: https://github.com/NixOS/nixpkgs/pull/368404
      "ghostty"
    ];
    taps = [
      "VOICEVOX/voicevox"
    ];
    masApps = {
      "Get Plain Text" = 508368068;
      Spark = 1176895641;
    };
  };
}
