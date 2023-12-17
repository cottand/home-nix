# Home Nix

This is a repo with 
 - my dotfiles [in `home/`](home/) (configured as a Nix [Home Manager](https://nix-community.github.io/home-manager/) module)
 - my laptop's NixOS config [in `nixos/`](nixos/)
 - an overlay with packages I often use [in `overlay.nix`](overlay.nix)

Usage:


```nix

# without flakes
    home-manager.users.cottand = (builtins.getFlake "github:cottand/home-nix").home;

# with flakes
    inputs.home = "github:cottand/home-nix";

    outputs = { home, ... }: {
        home-manager.users.cottand = home.home;
    };

```