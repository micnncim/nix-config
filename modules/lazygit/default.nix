{ config, lib, pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        commit.signOff = true;
        paging.pager = "${pkgs.delta}/bin/delta --dark --paging=never";
        disableForcePushing = true;
        autoFetch = false;
        autoRefresh = false;
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
        {
          key = "S";
          context = "localBranches";
          command = "op plugin run -- gh sync";
          description = "Sync repository";
          loadingText = "Syncing repository...";
        }
      ];
    };
  };
}
