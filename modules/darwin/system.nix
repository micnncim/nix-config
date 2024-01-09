{ config, lib, pkgs, username, ... }:

{
  system = {
    # Currently, application aren't linked to /Application.
    # https://github.com/LnL7/nix-darwin/issues/139#issuecomment-663117229
    build.applications = pkgs.lib.mkForce (pkgs.buildEnv {
      name = "applications";
      paths = config.environment.systemPackages
        ++ config.home-manager.users.${username}.home.packages;
      pathsToLink = "/Applications";
    });

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    # TODO(micnncim): Add more.
    defaults = {
      NSGlobalDomain = {
        "com.apple.trackpad.scaling" = 3.0;
        AppleInterfaceStyle = "Dark";
        AppleTemperatureUnit = "Celsius";
        InitialKeyRepeat = 20;
        KeyRepeat = 1;
      };

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        mineffect = "genie";
        orientation = "bottom";
        show-recents = false;
      };

      screencapture.location =
        "/Users/${username}/Google Drive/My Drive/Screenshots";

      trackpad.Clicking = true;
    };

    activationScripts.vscode.text = ''
      defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
    '';
  };
}
