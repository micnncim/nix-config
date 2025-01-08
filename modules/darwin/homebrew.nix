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
      "todoist"
      "visual-studio-code"
      "vivaldi"
      "voicevox"
      "zoom"
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
