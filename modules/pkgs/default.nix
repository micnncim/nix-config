{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      # Core
      coreutils
      curl
      tree
      watch
      wget

      # Utils
      eza
      jq
      markdownlint-cli
      neofetch
      procs
      ripsecrets
      rm-improved
      sd

      # Dev
      _1password
      (google-cloud-sdk.withExtraComponents
        ([ google-cloud-sdk.components.gke-gcloud-auth-plugin ]))
      git-lfs
      nodejs_18 # For CopilotForXcode
      shellcheck

      # Language servers
      nil
      nodePackages.bash-language-server
      yaml-language-server

      # Container
      kubectl
      kubectx
      podman
      qemu
      stern

      # Nix
      cachix
      comma
      niv
      nix-init
      nixpkgs-fmt
      nurl

      # Fonts
      nerdfonts
      ricty

      # NUR
      nur.repos.micnncim.gctx
      nur.repos.micnncim.kubectl-reveal-secret
      nur.repos.micnncim.slack-cli
    ];
}
