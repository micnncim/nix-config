{
  description = "Nix systems and tools by micnncim";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    # we'll use for our configurations. Be very careful changing this because
    # it'll impact your entire system.
    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";

    # We use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";

      # We want home-manager to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";

      # We want home-manager to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, nixpkgs-unstable, home-manager, darwin, ... }@inputs:
    let
      system = "aarch64-darwin";
      username = "micnncim";
      hostname = "${username}";

      nixpkgsConfig = {
        config = { allowUnfree = true; };
        overlays = import ./lib/overlays.nix ++ [
          (final: prev: {
            go = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.go_1_19;
            inherit (inputs.nixpkgs-unstable.legacyPackages.${prev.system})
              gh gopls;
          })
        ];
      };
    in
    {
      darwinConfigurations = {
        ${hostname} = darwin.lib.darwinSystem {
          inherit system;

          modules = [
            ./users/${username}/darwin.nix
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} =
                import ./users/${username}/home-manager.nix;
            }
          ];
        };
      };

      packages.${system}.default = home-manager.defaultPackage.${system};
    };
}
