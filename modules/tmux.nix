{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.copycat
      tmuxPlugins.fzf-tmux-url
      tmuxPlugins.logging
      tmuxPlugins.open
      tmuxPlugins.prefix-highlight
      tmuxPlugins.resurrect
      tmuxPlugins.tmux-fzf
      tmuxPlugins.yank
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5' # minutes
          set -g @continuum-boot 'on'
          set -g @continuum-boot-options 'alacritty' 
        '';
      }
      {
        plugin = tmuxPlugins.nord;
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
