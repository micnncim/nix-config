{ config, lib, pkgs, ... }:

{
  services.nix-daemon.enable = true;

  nix = {
    configureBuildUsers = true;

    # Enable experimental Nix command and Flakes.
    extraOptions = ''
      # https://github.com/NixOS/nix/issues/8939
      auto-optimise-store = false
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
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

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://micnncim-nix-config.cachix.org"
        "https://micnncim-nur.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "micnncim-nix-config.cachix.org-1:VYYe2Nwe1oFIkXavwNfp9L9F5S8LCLCA5/1YaFy9lFc="
        "micnncim-nur.cachix.org-1:RkC5K3iXncMrkWOUFDVaqe1o8fbq2ISBHg8e+zY5U7M="
      ];
    };
  };
}
