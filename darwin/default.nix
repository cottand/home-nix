{ inputs, pkgs, ... }:
let oldNixpkgs = builtins.getFlake "github:nixos/nixpkgs/c128e44a249d6180740d0a979b6480d5b795c013";
in
{
  imports = [
    ./system.nix
  ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim
    pkgs.iterm2
    pkgs.git
    pkgs.python311Packages.pip
    pkgs.rectangle

    (pkgs.callPackage ./packages/vfkit.nix { })
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    # until https://github.com/NixOS/nixpkgs/pull/356133 lands
    package = oldNixpkgs.legacyPackages.aarch64-darwin.nixVersions.nix_2_20;
    settings.experimental-features = "nix-command flakes";
    settings.auto-optimise-store = false;
    optimise.automatic = false;

    registry."nixpkgs".to = {
      path = toString inputs.nixpkgs;
      type = "path";
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  programs.fish.enable = true;

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  system.stateVersion = 4;

  nixpkgs.config.allowUnfree = true;
}
