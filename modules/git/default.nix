{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      git-absorb
      git-lfs
      git-sizer
    ];

  programs.git = {
    enable = true;
    userName = "micnncim";
    userEmail = "micnncim@gmail.com";
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOqrJp7F4TZm8SDX3Os6EQ9voET0QIz542VxTgO8OXLg";
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
      color.ui = "auto";
      init = {
        defaultBranch = "main";
        templatedir = "${config.xdg.configHome}/git/templates";
      };
      fetch.prune = true;
      push = {
        default = "upstream";
        autoSetupRemote = true;
      };
      pull.rebase = true;
      absorb = {
        oneFixupPerCommit = true;
        autoStageIfNothingStaged = true;
      };
    } // lib.optionals pkgs.stdenv.isDarwin {
      gpg = {
        format = "ssh";
        ssh = {
          program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
          allowedSignersFile = "${config.xdg.configHome}/git/allowed_signers";
        };
      };
      credential.helper = "osxkeychain";
    };
  };

  xdg.configFile = {
    "git/allowed_signers".source = ./allowed_signers;
    "git/hooks".source = ./hooks;
    "git/templates/hooks".source =
      config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/git/hooks";
  };
}
