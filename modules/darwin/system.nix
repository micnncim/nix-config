{ config, lib, pkgs, username, ... }:

{
  # Currently, application aren't linked to /Application.
  # https://github.com/LnL7/nix-darwin/issues/139#issuecomment-663117229
  system.build.applications = pkgs.lib.mkForce (pkgs.buildEnv {
    name = "applications";
    paths = config.environment.systemPackages
      ++ config.home-manager.users.${username}.home.packages;
    pathsToLink = "/Applications";
  });

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  # TODO(micnncim): Add more.
  system.defaults = {
    NSGlobalDomain = {
      "com.apple.trackpad.scaling" = 3.0;
      InitialKeyRepeat = 20;
      KeyRepeat = 1;
    };

    dock.autohide = true;

    screencapture.location =
      "/Users/${username}/Google Drive/My Drive/Screenshots";

    trackpad.Clicking = true;
  };

  system.activationScripts.vscode.text = ''
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
  '';
}
