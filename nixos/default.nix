{ pkgs, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      # ./builders.nix
      # ./hidpi.nix
      # ./gnome.nix
      # ./ides.nix
      # ./mixxx.nix

      ./common_config.nix
    ];


  # Wayland support for electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  # hardware.pulseaudio.enable = false;
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users.cottand = {
    isNormalUser = true;
    description = "Nico"; #                  android
    extraGroups = [ "networkmanager" "wheel" "adbusers" "docker" ];
    packages = with pkgs; [
      # chromium
      # spotify
      # stremio
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


  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  system.stateVersion = "22.11"; # Did you read the comment?

}
