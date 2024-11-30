{
  description = "Nix systems and tools by micnncim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nur.url = "github:nix-community/NUR";
    micnncim-nur.url = "github:micnncim/nur";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , flake-utils
    , nur
    , micnncim-nur
    , home-manager
    , darwin
    , nix-index-database
    , nix-homebrew
    , catppuccin
    , ...
    }@inputs:
    let
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

      mkDarwin = import ./lib/mk-darwin.nix {
        inherit inputs overlays;
      };
    in
    {
      darwinConfigurations.sirius = mkDarwin {
        system = "aarch64-darwin";
        machine = "sirius";
        username = "micnncim";
      };
      darwinConfigurations.vega = mkDarwin {
        system = "aarch64-darwin";
        machine = "vega";
        username = "micnncim";
      };
      darwinConfigurations.altair = mkDarwin {
        system = "aarch64-darwin";
        machine = "altair";
        username = "micnncim.v2";
      };
      darwinConfigurations.deneb = mkDarwin {
        system = "aarch64-darwin";
        machine = "denab";
        username = "micnncim";
      };
    } // flake-utils.lib.eachDefaultSystem (system: rec {
      pkgs = nixpkgs.legacyPackages.${system};

      devShells = {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            cachix
            jq
          ];
        };
      };
    });
}
