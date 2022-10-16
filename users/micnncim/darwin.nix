{ config, pkgs, lib, ... }:

# TODO(micnncim): Make this a function that accepts variables in `let`.
let username = "micnncim";
in
{
  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.fish;
  };

  #---------------------------------------------------------------------
  # Nix
  #---------------------------------------------------------------------

  nix = {
    trustedUsers = [ "@admin" ];

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

    binaryCaches = [ "https://micnncim-nix-config.cachix.org" ];
    binaryCachePublicKeys = [ "micnncim-nix-config.cachix.org-1:VYYe2Nwe1oFIkXavwNfp9L9F5S8LCLCA5/1YaFy9lFc=" ];
  };

  users.nix.configureBuildUsers = true;

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.nix-daemon.enable = true;

  homebrew = {
    enable = true;
    casks = [
      "1password"
      "alt-tab"
      "bartender"
      "cron"
      "discord"
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
    masApps = { Spark = 1176895641; };
  };

  #---------------------------------------------------------------------
  # Fonts
  #---------------------------------------------------------------------

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ nerdfonts ricty ];
  };

  #---------------------------------------------------------------------
  # Networking
  #---------------------------------------------------------------------

  networking = {
    computerName = "${username}";
    hostName = "${username}";
  };

  #---------------------------------------------------------------------
  # System Preferences
  #---------------------------------------------------------------------

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
    NSGlobalDomain = { KeyRepeat = 1; };

    dock.autohide = true;

    screencapture.location = "/Users/${username}/Google Drive/Screenshots";

    trackpad.Clicking = true;
  };
}
