{
  description = "Nico's dotfiles and Nix goodies";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      # url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, ... }:
    let
      modules = ./modules;
    in
    {
      # convenience overlay with what I usually use 
      homeManagerModules = {
        gui.imports = [
          ./home/vscode.nix
          ./home/gnome-dconf.nix
          ./home/ideavim.nix
        ];
        cli.imports = [
          ./home/fish.nix
          ./home/prompt.nix
          ./home/shell.nix
        ];
      };


      darwinConfigurations."Nicos-MacBook-Pro" = inputs.nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs modules; };
        modules = [ ./machines/m3 ./darwin ];
      };

      nixosModules.seaweedBinaryCache = ./modules/seaweedBinaryCache.nix;
      nixosModules.dcottaRootCa = ./modules/dcottaCa.nix;
      nixosModules.all = { imports = with self.nixosModules; [ seaweedBinaryCache dcottaRootCa ]; };
    };
}
