{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    # TODO(micnncim): Delete the whole module a while after we've migrated to
    # Ghostty.
    enable = false;

    # We manage most of the configuration in YAML files but here we manage some
    # values dynamically from Nix configuration and some tiny values for
    # convenience.
    settings = {
      general = {
        import = builtins.filter (lib.hasSuffix ".toml")
          (map (path: toString path)
            (lib.filesystem.listFilesRecursive ./alacritty)
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
}
