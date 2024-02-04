{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      copycat
      fzf-tmux-url
      logging
      open
      prefix-highlight
      resurrect
      tmux-fzf
      yank
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5' # minutes
          set -g @continuum-boot 'on'
          set -g @continuum-boot-options 'alacritty'
        '';
      }
      {
        plugin = nord;
        extraConfig = ''
          # Disable patched fonts.
          # https://www.nordtheme.com/docs/ports/tmux/configuration
          set -g @nord_tmux_no_patched_font '1'
        '';
      }
    ];
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
