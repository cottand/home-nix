{ inputs, name, pkgs, ... }: {
  imports = [
    ./hardware.nix
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = name;
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.cottand = {
      imports = with inputs.self.homeManagerModules; [ cli ];
      home.stateVersion = "22.11";
    };
    users.root = {
      imports = with inputs.self.homeManagerModules; [ cli ];
      home.stateVersion = "22.11";
    };
  };

  hardware.opengl = {
    enable = true;
  };

  
  services.spice-vdagentd.enable = true;
}
