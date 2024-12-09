{ config, lib, pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        commit.signOff = true;
        paging.pager = "${pkgs.delta}/bin/delta --dark --paging=never";
        autoFetch = false;
        autoRefresh = false;
        commitPrefix = {
          pattern = "^(micnncim\/)?([a-zA-Z0-9-_/]+)";
          replace = "$2: ";
        };
      };
      gui = {
        language = "en";
        commitAuthorShortLength = 8;
        commitAuthorLongLength = 16;
        spinner.frames = [ "⣾" "⣽" "⣻" "⢿" "⡿" "⣟" "⣯" "⣷" ];
      };
      update.method = "never";
      quitOnTopLevelReturn = true;
      disableStartupPopups = true;
      promptToReturnFromSubprocess = false;
      customCommands = [
        {
          key = "o";
          context = "localBranches";
          command = "if state=$(op plugin run -- gh pr view --json state --jq .state) && [ \"$state\" = \"OPEN\" ]; then op plugin run -- gh pr view --web; else op plugin run -- gh browse --branch {{.SelectedLocalBranch.Name}}; fi";
          description = "Open branch in browser";
          loadingText = "Opening branch in browser...";
        }
        {
          key = "O";
          context = "global";
          command = "git push && op plugin run -- gh pr create --fill --web";
          description = "Create pull request";
          loadingText = "Creating pull request...";
        }
        {
          key = "S";
          context = "global";
          command = "op plugin run -- gh sync";
          description = "Sync repository";
          loadingText = "Syncing repository...";
        }
        {
          key = "M";
          context = "localBranches";
          command = "op plugin run -- gh pr merge --squash --delete-branch";
          description = "Merge pull request";
          loadingText = "Merging pull request...";
        }
      ];
    };
  };
}
