{
  description = "Example Darwin system flake";

  inputs = {
    cottand.url = "github:Cottand/home-nix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, cottand }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
      };
      configuration = { pkgs, ... }: {
        # Search: $ nix-env -qaP | grep wget
        environment.systemPackages =
          [
            pkgs.vim
            pkgs.curl
            pkgs.direnv
            pkgs.entr
            pkgs.fzf
            pkgs.gettext
            pkgs.git
            pkgs.gnupg
            pkgs.home-manager
          ];
        users.users.nico.home = "/Users/nico";
        nixpkgs.config.allowUnfree = true;


        services.nix-daemon.enable = true;
        nix.package = pkgs.nix;

        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = system;
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Nicos-MacBook-Pro
      darwinConfigurations."Nicos-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Nicos-MacBook-Pro".pkgs;

      # Also expose homeManager as a flake output so we can switch home-manager
      # without having to use nix-darwin (so no sudo necessary!)
      homeConfigurations."nico" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix cottand.home ];
      };
    };
}
