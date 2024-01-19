{ config, lib, pkgs, username, ... }:

{
  programs.alacritty = {
    enable = true;
    # We manage most of the configuration in YAML files but here we manage some
    # values dynamically from Nix configuration and some tiny values for
    # convenience.
    settings = {
      import = map (path: "${config.xdg.configHome}/alacritty/${path}") [
        "colors.yml"
        "cursor.yml"
        "debug.yml"
        "font.yml"
        "keybindings.yml"
        "mouse.yml"
        "scrolling.yml"
        "selection.yml"
        "window.yml"
      ];
      env = {
        TERM = "xterm-256color";
        # NOTE(micnncim): This is a workaround for the issue that `shell` whose value
        # is `fish` does not start fish shell on macOS.
        #
        # See:
        # - https://github.com/alacritty/alacritty/issues/6412
        # - https://github.com/alacritty/alacritty/issues/6746
        SHELL = "/etc/profiles/per-user/${username}/bin/fish";
      };
      shell = {
        program = "/etc/profiles/per-user/${username}/bin/fish";
        args = [ "--login" ];
      };
      live_config_reload = true;
      working_directory = "None";
    };
  };

  xdg.configFile."alacritty" = {
    recursive = true;
    source = ./alacritty;
  };
}
