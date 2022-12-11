{ config, pkgs, lib, ... }:

# TODO(micnncim): Make this a function that accepts variables in `let`.
let username = "micnncim";
in
{
  #---------------------------------------------------------------------
  # Nix
  #---------------------------------------------------------------------

  nix = {
    configureBuildUsers = true;

    # Enable experimental Nix command and Flakes.
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';

    gc = {
      automatic = true;
      interval = { Hour = 24; };
      options = "--delete-older-than 7d";
    };

    settings = {
      trusted-users = [ "@admin" ];

      substituters = [ "https://micnncim-nix-config.cachix.org" ];
      trusted-public-keys = [ "micnncim-nix-config.cachix.org-1:VYYe2Nwe1oFIkXavwNfp9L9F5S8LCLCA5/1YaFy9lFc=" ];
    };
  };

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.nix-daemon.enable = true;

  # Some GUI applications are not available on nixpkgs.
  # Using Homebrew for convenience though it's possible to compose Nix packages
  # for these applications.
  homebrew = {
    enable = true;
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
      "bartender"
      "cron"
      "discord"
      "docker"
      "figma"
      "gather"
      "google-chrome"
      "google-drive"
      "google-japanese-ime"
      "karabiner-elements"
      "notion"
      "raycast"
      "stats"
      "vivaldi"
    ];
    masApps = {
      Magnet = 441258766;
      Spark = 1176895641;
    };
  };

  #---------------------------------------------------------------------
  # Fonts
  #---------------------------------------------------------------------

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ nerdfonts ricty ];
  };

  #---------------------------------------------------------------------
  # System Preferences
  #---------------------------------------------------------------------

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.fish;
  };

  environment = {
    loginShell = "/etc/profiles/per-user/${username}/bin/fish";
  };

  # Currently, applications aren't linked to /Application.
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
      ApplePressAndHoldEnabled = true;
      InitialKeyRepeat = 20;
      KeyRepeat = 1;
    };

    dock.autohide = true;

    screencapture.location = "/Users/${username}/Google \Drive/My \Drive/Screenshots";

    trackpad.Clicking = true;
  };
}
