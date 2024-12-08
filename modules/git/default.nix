{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      git-absorb
      git-sizer
    ];

  programs.git = {
    enable = true;
    userName = "micnncim";
    userEmail = "micnncim@gmail.com";
    signing = {
      key = lib.strings.trim (lib.strings.concatStringsSep " " (lib.lists.drop 1 (lib.splitString " " (builtins.readFile ./allowed_signers))));
      signByDefault = true;
    };
    aliases = {
      fixup = "!git log $(git remote show origin | grep 'HEAD branch' | cut -d ' ' -f 5)..HEAD --pretty=format:'%h %s' | fzf | awk '{print $1}' | xargs git commit --fixup";
      l = "log --date=short --pretty=format:'%C(yellow)%h %Cgreen%cd %Cblue%cn %Creset%s'";
      save = "!sh -c 'echo -n \"Enter stash message: \"; read message; git stash push -u -m \"$message\"'";
      sw = "!f() { if [[ $# -ge 1 ]] ; then git switch $@; else git switch $(git for-each-ref --format='%(refname:short)' refs/heads/ | fzf); fi }; f";
    };
    delta = {
      enable = true;
      options = {
        dark = true;
        line-numbers = true;
        navigate = true;
      };
    };
    lfs = {
      enable = true;
      skipSmudge = true;
    };
    ignores = lib.splitString "\n" (builtins.readFile ./.gitignore);
    extraConfig = {
      absorb = {
        autoStageIfNothingStaged = true;
        maxStack = 100;
        oneFixupPerCommit = true;
      };
      color.ui = "auto";
      fetch.prune = true;
      init = {
        defaultBranch = "main";
        templateDir = "${config.xdg.configHome}/git/templates";
      };
      pull = {
        ff = "only";
        rebase = true;
      };
      push = {
        default = "upstream";
        autoSetupRemote = true;
      };
      rebase.autoSquash = true;
    } // lib.optionals pkgs.stdenv.isDarwin {
      credential.helper = "osxkeychain";
      gpg = {
        format = "ssh";
        ssh = {
          program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
          allowedSignersFile = toString ./allowed_signers;
        };
      };
    };
  };

  xdg.configFile = {
    "git/hooks".source = ./hooks;
    "git/templates/hooks".source =
      config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/git/hooks";
  };
}
