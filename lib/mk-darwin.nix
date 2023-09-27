{ inputs, overlays }:

{ system, username }:

inputs.darwin.lib.darwinSystem {
  inherit system;

  modules = [
    ../users/${username}/darwin.nix
    inputs.home-manager.darwinModules.home-manager
    {
      nixpkgs = {
        config = { allowUnfree = true; };
        overlays = overlays;
      };

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${username} =
        import ../users/${username}/home-manager.nix;
    }
  ];
}
