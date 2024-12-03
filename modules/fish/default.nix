{ config, lib, pkgs, username, ... }:

let
  sources = import ../../nix/sources.nix;
in
{
  programs.fish = {
    enable = true;
    functions = {
      # Do not show any greeting
      fish_greeting = "";
      fish_user_key_bindings = ''
        bind \c] __ghq_jump
        bind \cg lazygit
      '';
    } // builtins.listToAttrs (map
      (path: {
        name = (lib.strings.removeSuffix ".fish" (builtins.baseNameOf path));
        value = (builtins.readFile path);
      })
      (builtins.filter
        (lib.hasSuffix ".fish")
        (lib.filesystem.listFilesRecursive ./functions)
      )
    );
    interactiveShellInit = lib.strings.concatStrings
      (lib.strings.intersperse "\n" [
        "fish_add_path /etc/profiles/per-user/${username}/bin"
        "source ${pkgs.google-cloud-sdk}/google-cloud-sdk/path.fish.inc"
        "set -x LS_COLORS \"$(${pkgs.vivid}/bin/vivid generate catppuccin-mocha)\""
        (builtins.readFile ./config.fish)
      ]);
    plugins = map
      (n: {
        name = n;
        src = sources.${n};
      }) [
      "fish-bass"
      "fish-foreign-env"
      "fish-gcloud-completion"
      "fish-nix-env"
    ];
  };
}
