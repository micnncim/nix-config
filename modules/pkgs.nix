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
      bat
      fd
      jq
      neofetch
      pre-commit
      procs
      ripgrep
      rm-improved
      sd
      tealdeer
      typos
      unstable.atuin
      unstable.eza
      unstable.markdownlint-cli
      unstable.ripsecrets

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
      unstable.yaml-language-server

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

      # NUR
      nur.repos.micnncim.gctx
      nur.repos.micnncim.kubectl-reveal-secret
      nur.repos.micnncim.slack-cli
    ] ++ lib.optionals stdenv.isDarwin [ pinentry_mac ];
}
