{ darwin, home-manager, system, username, overlays }:

darwin.lib.darwinSystem rec {
  inherit system;

  modules = [
    ../users/${username}/darwin.nix
    home-manager.darwinModules.home-manager
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
