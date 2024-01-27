{ inputs, modules, ... }: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nico = {
      imports = with inputs.self.homeManagerModules; [ cli gui ./home (modules + /darwinAppSymlink.nix) ];
      home.stateVersion = "23.11";
      home.username = "nico";
      home.homeDirectory = "/Users/nico";
    };
  };


  nixpkgs.hostPlatform = "aarch64-darwin";
  users.users."nico".home = "/Users/nico";
}
