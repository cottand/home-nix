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

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, ... }: {
    # convenience overlay with what I usually usehttps://gitlab.gnome.org/GNOME/mutter/-/commit/3ac82a58c51a5c8db6b49e89a1232f99c79644cc.patch
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

    nixosModules = {
      uploadToSeaweedPostBuild = { ... }: {
        nix.extraOptions = "post-build-hook = ./etc/nix/upload-to-cache.sh;";
        environment.etc."nix/scripts/upload-to-cache.sh".source = ./scripts/upload-to-cache.sh;
      };
    };

    # my laptop's config - I use colmena rather than nixos-rebuild because I like the CLI c: 
    colmena = {
      meta = {
        nixpkgs = import nixpkgs { system = "x86_64-linux"; };
        specialArgs.inputs = inputs;
      };
      nico-xps = { name, ... }: {
        nixpkgs = {
          overlays = [ self.overlay ];
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
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
          self.nixosModules.uploadToSeaweedPostBuild
          nixos-hardware.nixosModules.dell-xps-13-9300
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.cottand = {
              imports = with self.homeManagerModules; [ cli gui ];
              home.stateVersion = "22.11";
            };
            home-manager.users.root = {
              imports = with self.homeManagerModules; [ cli ];
              home.stateVersion = "22.11";
            };
          }
        ];
      };
    };
  };
}
