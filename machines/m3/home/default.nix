{ pkgs, ... }: {
  home.packages = with pkgs; with pkgs.jetbrains; [
    idea-ultimate
    goland
    webstorm
    zed-editor

    spotify

    monitorcontrol

    utm
    nicotine-plus

  ];

  home.shellAliases."tailscale" = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
}
