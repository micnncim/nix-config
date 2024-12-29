{ config, lib, pkgs, ... }:

let
  tmuxPrefix = "\\x14"; # \x14 (Ctrl+t)
in
{
  # TODO(micnncim): Switch to Home Manager after the following PR is merged:
  # Ref: https://github.com/nix-community/home-manager/pull/6235
  xdg.configFile."ghostty/config".text = lib.generators.toKeyValue { listsAsDuplicateKeys = true; } {
    theme = "catppuccin-mocha";
    font-family = "MonaspiceNe Nerd Font";
    font-size = 16;

    window-padding-x = 10;
    window-padding-y = 10;

    # Set " " to hide the title
    title = ''" "'';

    command = "${pkgs.tmux}/bin/tmux";

    keybind = [
      "super+t=text:${tmuxPrefix}c" # Create a new tmux window
      "super+w=text:${tmuxPrefix}&" # Close a tmux window
      "super+shift+c=text:${tmuxPrefix}[" # Start copy mode
      "super+one=text:${tmuxPrefix}1" # Switch to window 1
      "super+two=text:${tmuxPrefix}2" # Switch to window 2
      "super+three=text:${tmuxPrefix}3" # Switch to window 3
      "super+four=text:${tmuxPrefix}4" # Switch to window 4
      "super+five=text:${tmuxPrefix}5" # Switch to window 5
      "super+six=text:${tmuxPrefix}6" # Switch to window 6
      "super+seven=text:${tmuxPrefix}7" # Switch to window 7
      "super+eight=text:${tmuxPrefix}8" # Switch to window 8
      "super+nine=text:${tmuxPrefix}9" # Switch to window 9
    ];
  };
}
