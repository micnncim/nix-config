{ inputs, overlays }:

{ system, username }:

inputs.darwin.lib.darwinSystem {
  inherit system;

  modules = [
    ../modules/darwin.nix
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
    {
      nixpkgs = {
        config = { allowUnfree = true; };
        overlays = overlays;
      };

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${username} = import ../modules/home-manager.nix {
        inherit inputs username;
      };

      nix-homebrew = {
        enable = true;
        enableRosetta = true;
        user = "${username}";
        # autoMigrate = true;
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
