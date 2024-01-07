{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "micnncim";
    userEmail = "micnncim@gmail.com";
    signing = {
      key = "6FE4E6E1";
      signByDefault = true;
      gpgPath = "${pkgs.gnupg}/bin/gpg";
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
      ghq.root = "${config.home.homeDirectory}/src";
    } // lib.optionals pkgs.stdenv.isDarwin {
      credential.helper = "osxkeychain";
    };
  };
}
