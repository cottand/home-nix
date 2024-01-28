{ pkgs, inputs, ... }:

{
  imports =
    [
      # ./builders.nix
      ./hidpi.nix
      ./gnome.nix
      ./ides.nix
      ./mixxx.nix

      ./hardware-configuration.nix
    ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.cottand = {
      imports = with inputs.self.homeManagerModules; [ cli gui ];
      home.stateVersion = "22.11";
    };
    users.root = {
      imports = with inputs.self.homeManagerModules; [ cli ];
      home.stateVersion = "22.11";
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  networking.hostName = "nico-xps"; # Define your hostname.

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      # intel-media-driver # LIBVA_DRIVER_NAME=iHD
      # vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Wayland support for electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable networking
  networking.networkmanager.enable = true;


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  users.users.cottand = {
    isNormalUser = true;
    description = "Nico"; #                  android
    extraGroups = [ "networkmanager" "wheel" "adbusers" "docker" ];
    packages = with pkgs; [
      chromium
      spotify
      stremio
    ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    gparted
    gh
    git
    nomad_1_7
    # scrcpy # android screen sharing
    gnome3.gnome-tweaks

    nixVersions.unstable

    colmena
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  system.stateVersion = "22.11"; # Did you read the comment?
}
