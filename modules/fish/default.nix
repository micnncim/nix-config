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
      (n: {
        name = n;
        value = (builtins.readFile ./functions/${n}.fish);
      }) [
      "__abbr_flag_ctx"
      "__abbr_flag_n"
      "__abbr_flag_o"
      "__abbr_flag_p"
      "__abbr_subcommand_a"
      "__abbr_subcommand_ab"
      "__abbr_subcommand_b"
      "__abbr_subcommand_c"
      "__abbr_subcommand_d"
      "__abbr_subcommand_f"
      "__abbr_subcommand_g"
      "__abbr_subcommand_g"
      "__abbr_subcommand_l"
      "__abbr_subcommand_l"
      "__abbr_subcommand_pl"
      "__abbr_subcommand_ps"
      "__abbr_subcommand_r"
      "__abbr_subcommand_rs"
      "__abbr_subcommand_s"
      "__ghq_jump"
      "fkill"
      "help"
      "xcode"
    ]);
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
