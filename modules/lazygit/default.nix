{ config, lib, pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        commit.signOff = true;
        paging.pager = "${pkgs.delta}/bin/delta --dark --paging=never";
        disableForcePushing = true;
      };
      gui = {
        language = "en";
        commitAuthorShortLength = 16;
        commitAuthorLongLength = 24;
      };
      update.method = "never";
      quitOnTopLevelReturn = true;
      disableStartupPopups = true;
      promptToReturnFromSubprocess = false;
    };
  };
}
