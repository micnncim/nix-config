{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 1000000;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    prefix = "C-t";
    sensibleOnTop = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [
      copycat
      fzf-tmux-url
      logging
      open
      prefix-highlight
      tmux-fzf
      yank
    ];
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
