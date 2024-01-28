{ config, pkgs, lib, ... }:
{

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc.automatic = true;
    gc.options = "--delete-older-than 30d";
    gc.dates = "weekly";
    optimise.automatic = true;
    settings = {
      auto-optimise-store = true;
      allowed-users = [ "@wheel" ];
      trusted-users = [ "root" "@wheel" ];
    };
  };


  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 1 * 1024;
  }];

  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;
  services.sshguard.enable = true;

  networking.enableIPv6 = true;
  programs.zsh.enable = true;

  # Enable Oh-my-zsh
  programs.zsh.ohMyZsh = {
    enable = true;
    theme = "fishy";
    plugins = [ "git" "sudo" "docker" "systemadmin" ];
  };

  users.users.root.shell = pkgs.fish;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHcVLH2EH/aAkul8rNWrDoBTjUTL3Y+6vvlVw5FSh8Gt nico.dc@outlook.com-m3"
  ];

  environment.systemPackages = with pkgs; [
    wireguard-tools
    python3 # required for sshuttle
    pciutils # for setpci, lspci
    dig
    iw
    vim
    htop
    s-tui # power top
    nmap
    traceroute
  ];

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # see https://blog.thalheim.io/2022/12/31/nix-ld-a-clean-solution-for-issues-with-pre-compiled-executables-on-nixos/
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      fuse3
      icu
      zlib
      nss
      openssl
      curl
      wget
      expat
    ];
  };
}
