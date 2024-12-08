{ config, lib, pkgs, username, ... }:

let
  sources = import ../../nix/sources.nix;

  functions = builtins.filter
    (lib.hasSuffix ".fish")
    (lib.filesystem.listFilesRecursive ./functions);
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
      functions
    );
    shellAbbrs = {
      bat = { expansion = "bat"; regex = "^cat$"; };
      cursor = { expansion = "cursor"; regex = "^c$"; };
      ghq = { expansion = "ghq get -p"; regex = "^ghq$"; };
      git = { expansion = "git"; regex = "^g$"; };
      help = { expansion = "help"; regex = "^h$"; };
      kubectl = { expansion = "kubectl"; regex = "^k$"; };
      kubectx = { expansion = "kubectx"; regex = "^kc$"; };
      kubens = { expansion = "kubens"; regex = "^kn$"; };
      make = { expansion = "make"; regex = "^m$"; };
      mkdir = { expansion = "mkdir -p"; regex = "^mkdir$"; };
      nvim = { expansion = "nvim"; regex = "^v$"; };
      rip = { expansion = "rip"; regex = "^rm$"; };
      xcode = { expansion = "xcode"; regex = "^x$"; };
    } // (
      builtins.listToAttrs (map
        (path:
          let
            basename = lib.strings.removeSuffix ".fish" (builtins.baseNameOf path);
            parts = lib.strings.splitString "_" (lib.strings.removePrefix "__abbr_" basename);
            type = builtins.elemAt parts 0; # "flag" or "subcommand"
            name = builtins.elemAt parts 1;
          in
          {
            name = if type == "flag" then "-${name}" else "${name}";
            value = {
              function = basename;
              position = "anywhere";
            };
          })
        (
          builtins.filter
            (path: lib.hasPrefix "__abbr_" (builtins.baseNameOf path))
            functions
        )
      )
    );
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
    interactiveShellInit = ''
      fish_add_path /opt/homebrew/bin
      fish_add_path $GOBIN

      source ${pkgs.google-cloud-sdk}/google-cloud-sdk/path.fish.inc
      swift package completion-tool generate-fish-script | source

      set -x LS_COLORS \"$(${pkgs.vivid}/bin/vivid generate catppuccin-mocha)\"

      if isatty
        set -x GPG_TTY (tty)
      end

      if not set -q TMUX
        exec tmux; or echo "failed to launch tmux"
      end
    '';
  };
}
