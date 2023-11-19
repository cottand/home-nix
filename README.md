# Home Nix

This is a small repo with my dotfiles (configured as a Nix [Home Manager](https://nix-community.github.io/home-manager/) module) and some Nix utilities.

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