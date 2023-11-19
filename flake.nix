{
  description = "Nico's dotfiles and Nix goodies";


  outputs = { self, ... }: {
    # a home-manager module
    home = import ./home;

    # convenience overlay with what I usually use
    overlay = (import ./overlay.nix);
  };
}
