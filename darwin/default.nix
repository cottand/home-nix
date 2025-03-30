{ inputs, pkgs, ... }:
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

  nix = {
    enable = true;
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
