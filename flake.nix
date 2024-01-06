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

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.stable.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, colmena, ... }: {
    # convenience overlay with what I usually use 
    overlay = (import ./overlay.nix) inputs;

    homeManagerModules.gui.imports = [
      ./home/vscode.nix
      ./home/gnome-dconf.nix
      ./home/ideavim.nix
    ];
    homeManagerModules.cli.imports = [
      ./home/fish.nix
      ./home/prompt.nix
      ./home/shell.nix
    ];

    nixosModules.seaweedBinaryCache = ./modules/seaweedBinaryCache.nix;
    nixosModules.dcottaRootCa = ./modules/dcottaCa.nix;
    nixosModules.all = { imports = with self.nixosModules; [ seaweedBinaryCache dcottaRootCa ]; };

    # my laptop's config - I use colmena rather than nixos-rebuild because I like the CLI c: 
    colmena = {
      meta.nixpkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ self.overlay colmena.overlay ];
        config.allowUnfree = true;
      };
      nico-xps = { name, ... }: {
        deployment = {
          # Allow local deployment with `colmena apply-local`
          allowLocalDeployment = true;

          # Disable SSH deployment. This node will be skipped in a
          # normal`colmena apply`.
          targetHost = null;
          replaceUnknownProfiles = true;
        };
        networking.hostName = name;
        imports = [
          ./nixos
          self.nixosModules.all
          {
            cottand.seaweedBinaryCache.useSubstituter = true;
          }
          nixos-hardware.nixosModules.dell-xps-13-9300
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.cottand = {
                imports = with self.homeManagerModules; [ cli gui ];
                home.stateVersion = "22.11";
              };
              users.root = {
                imports = with self.homeManagerModules; [ cli ];
                home.stateVersion = "22.11";
              };
            };
          }
        ];
      };
    };
  };
}
