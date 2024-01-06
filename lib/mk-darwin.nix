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
      home-manager.users.${username} = ../modules/home.nix;
      home-manager.extraSpecialArgs = {
        inherit inputs overlays system username;
      };

      nix-homebrew = {
        enable = true;
        enableRosetta = true;
        user = "${username}";
      };
    }

    # We expose some extra arguments so that our modules can parameterize
    # better based on these values.
    {
      config._module.args = {
        # inherit inputs overlays system username;
        inputs = inputs;
        overlays = overlays;
        system = system;
        username = username;
      };
    }
  ];
}
