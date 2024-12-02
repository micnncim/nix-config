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

      # Shell
      dust
      eza
      fastfetch
      jq
      parallel
      procs
      ripsecrets
      rm-improved
      sd

      # Utilities
      _1password-cli
      (google-cloud-sdk.withExtraComponents
        ([ google-cloud-sdk.components.gke-gcloud-auth-plugin ]))
      hyperfine
      imagemagick
      markdownlint-cli
      semgrep
      shellcheck
      shfmt
      vhs

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

      # Required for Copilot.vim and Copilot for Xcode
      nodejs_18

      # NUR
      nur.repos.micnncim.gctx
      # nur.repos.micnncim.kubectl-reveal-secret
      nur.repos.micnncim.slack-cli
    ] ++ lib.optionals pkgs.stdenv.isDarwin [
      unstable.ice-bar

      # NUR
      nur.repos.micnncim.vfkit
    ];
}
