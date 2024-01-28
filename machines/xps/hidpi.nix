{ config, pkgs, lib, ... }:
{
  services.xserver.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';
    extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];

  };

}
