{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    tmux = {
      extraConfig = ''
        set -g @catppuccin_window_status_style 'rounded'
        set -g @catppuccin_window_default_fill 'number'
        set -g @catppuccin_window_text ' #W'
        set -g @catppuccin_window_current_text ' #W'
        set -g @catppuccin_window_current_fill 'number'
        set -g @catppuccin_status_modules_right 'date_time'
        set -g @catppuccin_status_modules_left 'session'
        set -g @catppuccin_status_right_separator_inverse 'no'
        set -g @catppuccin_status_fill 'icon'
        set -g @catppuccin_status_connect_separator 'no'
        set -g @catppuccin_date_time_text '%H:%M'
        set -g @catppuccin_application_icon ' '
      '';
    };
  };
}
