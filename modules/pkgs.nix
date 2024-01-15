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
      atuin
      bat
      eza
      fd
      jq
      markdownlint-cli
      neofetch
      pre-commit
      procs
      ripgrep
      ripsecrets
      rm-improved
      sd
      tealdeer
      typos

      # Dev
      (google-cloud-sdk.withExtraComponents
        ([ google-cloud-sdk.components.gke-gcloud-auth-plugin ]))
      ghq
      git-lfs
      nodejs_18 # For CopilotForXcode
      pinentry
      shellcheck
      starship

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
    ] ++ lib.optionals stdenv.isDarwin [
      aria
      pinentry_mac
      skhd
      xcodes
    ];
}
