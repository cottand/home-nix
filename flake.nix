{
  description = "Nico's dotfiles and Nix goodies";
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";

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

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.stable.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, colmena, ... }:
    let
      modules = ./modules;
    in
    {
      # convenience overlay with what I usually use 
      overlay = (import ./overlay.nix) inputs;
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

      # my laptop's config - I use colmena rather than nixos-rebuild because I like the CLI c: 
      colmena = {
        meta.nixpkgs = import nixpkgs {
          system = "aarch64-linux";
        };
        meta.specialArgs = { inherit inputs; };
        meta.nodeNixpkgs.nixo-xps = import nixpkgs {
          system = "x86_64-linux";
          overlays = [ self.overlay colmena.overlay ];
          config.allowUnfree = true;
        };
        meta.nodeNixpkgs.nixosBuilder = import nixpkgs {
          system = "aarch64-linux";
          overlays = [ self.overlay colmena.overlay ];
          config.allowUnfree = true;
        };

        nico-xps = { name, ... }: {
          deployment = {
            allowLocalDeployment = true;
            targetHost = null;
            replaceUnknownProfiles = true;
          };
          networking.hostName = name;
          imports = [
            ./nixos
            self.nixosModules.all
            nixos-hardware.nixosModules.dell-xps-13-9300
            home-manager.nixosModules.home-manager
          ];
        };

        nixosBuilder = { name, ... }: {
          deployment = {
            # allowLocalDeployment = true;
            targetHost = "192.168.64.2";
            replaceUnknownProfiles = true;
            buildOnTarget = true;
          };
          networking.hostName = name;
          imports = [
            ./machines/nixosBuilder/default.nix
            ./nixos
            self.nixosModules.all
            home-manager.nixosModules.home-manager
          ];
        };
      };
    };
}
