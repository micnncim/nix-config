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
        spinner.frames = [ "⣾" "⣽" "⣻" "⢿" "⡿" "⣟" "⣯" "⣷" ];
      };
      update.method = "never";
      quitOnTopLevelReturn = true;
      disableStartupPopups = true;
      promptToReturnFromSubprocess = false;
      customCommands = [
        {
          key = "O";
          context = "global";
          command = "git push && op plugin run -- gh pr create --fill --web";
          description = "Create pull request";
          loadingText = "Creating pull request...";
        }
      ];
    };
  };
}
