{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "micnncim";
    userEmail = "micnncim@gmail.com";
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOqrJp7F4TZm8SDX3Os6EQ9voET0QIz542VxTgO8OXLg";
      signByDefault = true;
    };
    aliases = {
      a = "add";
      b = "branch";
      c = "commit -s";
      d = "diff";
      l = "log --date=short --pretty=format:'%C(yellow)%h %Cgreen%cd %Cblue%cn %Creset%s'";
      pl = "pull";
      ps = "push";
      r = "remote";
      rs = "reset";
      save = "!sh -c 'echo -n \"Enter stash message: \"; read message; git stash push -u -m \"$message\"'";
      st = "status";
      sw = "!f() { if [[ $# -ge 1 ]] ; then git switch $@; else git switch $(git for-each-ref --format='%(refname:short)' refs/heads/ | fzf); fi }; f";
    };
    delta = {
      enable = true;
      options = {
        dark = true;
        syntax-theme = "Nord";
        line-numbers = true;
        navigate = true;
      };
    };
    extraConfig = {
      color.ui = "auto";
      init = {
        defaultBranch = "main";
        templatedir = "${config.xdg.configHome}/git/templates";
      };
      push = {
        default = "upstream";
        autoSetupRemote = true;
      };
      pull.rebase = true;
      url."git@github.com:".insteadOf = "https://github.com";
      ghq.root = "${config.home.homeDirectory}/src";
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
    "git" = {
      recursive = true;
      source = ./git;
    };
    "git/templates/hooks".source =
      config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/git/hooks";
  };
}
