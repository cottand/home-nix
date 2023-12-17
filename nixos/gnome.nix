{ config, pkgs, ... }:
{

  # nixpkgs.overlays = [
  #   (self: super: {
  #     gnome = super.gnome.overrideScope' (pself: psuper: {
  #       mutter = psuper.mutter.overrideAttrs (oldAttrs: {
  #         patches = (oldAttrs.patches or [ ]) ++ [
  #           (super.fetchpatch {
  #             url = "https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/1441.patch";
  #             hash = "sha256-5r4UP4njxrfRebItzQBPrTKaPUzkWA+9727YdWgBCpA=";
  #             # revert = true;
  #           })
  #         ];
  #       });
  #     });
  #   })
  # ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  # pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    # gnome-terminal
    # gedit # text editor
    epiphany # web browser
    geary # email reader
    # evince # document viewer
    gnome-characters
    # totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';
  hardware.i2c.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];


  # missing extensions not installed from NixOS https://extensions.gnome.org/extension/4652/adjust-display-brightness/
  environment.systemPackages = with pkgs; [
    # monitor control
    ddcutil

    gnome.dconf-editor

    (makeAutostartItem { name = "guake"; package = guake; })
    gnomeExtensions.vitals
    # gnomeExtensions.useless-gaps
    gnomeExtensions.wireless-hid

    gnomeExtensions.unite

    # sound
    pavucontrol
  ];
  environment.sessionVariables."GUAKE_ENABLE_WAYLAND" = "true";
}