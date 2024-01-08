{ config, lib, pkgs, ... }:

lib.mkIf pkgs.stdenv.isDarwin {
  xdg.configFile."xcode" = {
    recursive = true;
    source = ./xcode;
  };

  # Seems symlink doesn't work for Xcode themes.
  # Related: https://github.com/dracula/xcode/issues/7
  home.activation.copyXcodeThemes = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD cp -f ${config.xdg.configHome}/xcode/Nord.xccolortheme ${config.home.homeDirectory}/Library/Developer/Xcode/UserData/FontAndColorThemes/Nord.xccolortheme
  '';

  home.file."${config.home.homeDirectory}/Library/Developer/Xcode/UserData/IDETemplateMacros.plist".source =
    ./xcode/IDETemplateMacros.plist;
}
