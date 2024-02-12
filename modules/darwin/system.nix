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
        AppleInterfaceStyle = "Dark";
        AppleTemperatureUnit = "Celsius";
        InitialKeyRepeat = 20;
        KeyRepeat = 1;
        _HIHideMenuBar = true; # We use SketchyBar.
        "com.apple.trackpad.scaling" = 3.0;
      };

      dock = {
        autohide = true;
        mineffect = "scale";
        minimize-to-application = true;
        orientation = "bottom";
        show-recents = false;
      };

      finder = {
        _FXShowPosixPathInTitle = true;
        AppleShowAllFiles = true;
        FXPreferredViewStyle = "clmv"; # Column view.
        ShowPathbar = false;
        ShowStatusBar = true;
      };

      screencapture.location =
        "/Users/${username}/Google Drive/My Drive/Screenshots";

      trackpad.Clicking = true;

      CustomUserPreferences = {
        "com.apple.Terminal" = {
          # skhd requires Secure Keyboard Entry to be disabled.
          "SecureKeyboardEntry" = false;
        };
        "com.apple.dt.Xcode" = {
          "ShowBuildOperationDuration" = true;
          "XCFontAndColorCurrentDarkTheme" = "Nord.xccolortheme";
        };
        "com.apple.dt.XCBuild" = {
          "EnableSwiftBuildSystemIntegration" = true;
        };
        "com.microsoft.VSCode" = {
          # https://github.com/vscode-neovim/vscode-neovim#vscode-configuration
          "ApplePressAndHoldEnabled" = false;
        };
      };
    };
  };
}
