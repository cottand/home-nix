{
  description = "Nico's dotfiles and Nix goodies";

  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = inputs@{ self, ... }: {
    # a home-manager module
    home = import ./home;

    # convenience overlay with what I usually use
    overlay = (import ./overlay.nix) inputs;
  };
}
