{ inputs, overlays }:

{ system, username }:

inputs.darwin.lib.darwinSystem {
  inherit system;

  modules = [
    {
      nixpkgs = {
        config = { allowUnfree = true; };
        overlays = overlays;
      };
    }

    ../modules/darwin
    inputs.home-manager.darwinModules.home-manager

    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${username} = ../modules/home;
      home-manager.extraSpecialArgs = {
        inherit inputs overlays system username;
      };
    }

    inputs.nix-index-database.darwinModules.nix-index

    inputs.nix-homebrew.darwinModules.nix-homebrew
    {
      nix-homebrew = {
        enable = true;
        enableRosetta = true;
        user = username;
      };
    }

    # We expose some extra arguments so that our modules can parameterize
    # better based on these values.
    {
      config._module.args = {
        inherit inputs overlays system username;
      };
    }
  ];
}
