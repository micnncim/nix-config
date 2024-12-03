{ config, lib, pkgs, username, ... }:

{
  programs.alacritty = {
    enable = true;
    # We manage most of the configuration in YAML files but here we manage some
    # values dynamically from Nix configuration and some tiny values for
    # convenience.
    settings = {
      general = {
        import = map (path: "${config.xdg.configHome}/alacritty/${path}")
          (map
            (path: builtins.baseNameOf path)
            (builtins.filter
              (lib.hasSuffix ".toml")
              (lib.filesystem.listFilesRecursive ./alacritty)
            )
          );
        live_config_reload = true;
        working_directory = "None";
      };
      terminal.shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [ "--login" ];
      };
    };
  };

  xdg.configFile."alacritty" = {
    recursive = true;
    source = ./alacritty;
  };
}
