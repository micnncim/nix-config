{
  description = "Nix systems and tools by micnncim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nur.url = "github:nix-community/NUR";
    micnncim-nur.url = "github:micnncim/nur";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nur, micnncim-nur, home-manager
    , darwin, ... }@inputs:
    let
      mkDarwin = import ./lib/mk-darwin.nix;

      overlays = import ./lib/overlays.nix ++ [
        (final: prev: {
          unstable = import nixpkgs-unstable {
            system = prev.system;
            config.allowUnfree = true;
          };
          nur = import nur {
            nurpkgs = prev;
            pkgs = prev;
            repoOverrides = {
              micnncim = import micnncim-nur { pkgs = prev; };
            };
          };
        })
      ];
    in {
      darwinConfigurations = {
        sirius = mkDarwin {
          inherit darwin home-manager overlays;
          system = "aarch64-darwin";
          username = "micnncim";
        };
      };
    };
}
