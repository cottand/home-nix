{ pkgs, ... }: {
  home.packages = with pkgs; with pkgs.jetbrains; [
    idea-ultimate
    goland
    webstorm

    spotify

    utm
  ];
}
