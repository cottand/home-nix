{ pkgs, ... }: {
  home.packages = with pkgs; [
    spotify
    wireguard-tools
    
  ];
}