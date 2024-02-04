{ config, lib, pkgs, ... }:

{
  xdg.enable = true;

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
    PAGER = "less";
    MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
    # https://github.com/sharkdp/bat/issues/652#issuecomment-529032263
    MANROFFOPT = "-c";
    # https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
    USE_GKE_GCLOUD_AUTH_PLUGIN = "True";
  };

  home.shellAliases = {
    ll = "eza -la";
    llt =
      "eza -laTF --git --group-directories-first --git-ignore --ignore-glob .git";
    ls = "eza";
    lt = "eza -T";
  };
}
