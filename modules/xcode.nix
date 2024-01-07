{ config, lib, pkgs, ... }:

lib.mkIf pkgs.stdenv.isDarwin {
  # Seems symlink doesn't work for Xcode themes.
  # Related: https://github.com/dracula/xcode/issues/7
  # home.file."${config.home.homeDirectory}/Library/Developer/Xcode/UserData/FontAndColorThemes/Nord.xccolortheme".source =
  #   ./xcode/Nord.xccolortheme;

  home.file."${config.home.homeDirectory}/Library/Developer/Xcode/UserData/IDETemplateMacros.plist".source =
    ./xcode/IDETemplateMacros.plist;
}
