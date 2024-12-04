{ config, lib, pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;
    spotifyPackage = pkgs.unstable.spotify;
    # https://github.com/Gerg-L/spicetify-nix/issues/238
    spicetifyPackage = pkgs.unstable.spicetify-cli;
    enabledExtensions = with spicePkgs.extensions; [
      history
      keyboardShortcut
      shuffle
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
