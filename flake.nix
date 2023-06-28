{
  description = "Nix systems and tools by micnncim";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    # we'll use for our configurations. Be very careful changing this because
    # it'll impact your entire system.
    nixpkgs.url = "github:nixos/nixpkgs/release-23.05";

    # We use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";

      # We want home-manager to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";

      # We want home-manager to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, nixpkgs-unstable, home-manager, darwin, ... }@inputs:
    let
      mkDarwin = import ./lib/mk-darwin.nix;

      overlays = import ./lib/overlays.nix ++ [
        (final: prev: {
          # Example of bringing in an unstable package:
          # go = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.go_1_19;
          unstable = import nixpkgs-unstable {
            system = prev.system;
            config.allowUnfree = true;
          };
        })
      ];
    in
    {
      darwinConfigurations = {
        micnncim = mkDarwin rec {
          inherit darwin home-manager overlays;
          system = "aarch64-darwin";
          username = "micnncim";
        };
      };
    };
}
