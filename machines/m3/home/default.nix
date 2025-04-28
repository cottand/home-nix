{ pkgs, ... }: {
  home.packages = with pkgs; with pkgs.jetbrains; [
    idea-ultimate
    goland
    webstorm

    spotify

    monitorcontrol

    utm
    nicotine-plus

    nixd
    go
    ollama
  ];

  home.shellAliases."tailscale" = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
}
