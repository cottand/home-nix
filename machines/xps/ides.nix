{ pkgs, ... }:
{
  users.users.cottand.packages = [
    pkgs.jetbrains.idea
    pkgs.jetbrains.goland
    pkgs.jetbrains.webstorm
    #pkgs.jetbrains.pycharm-professional
    #(pkgs.python310.withPackages(ps: with ps; [ pandas requests jupyter_core ]))

    pkgs.python3
    pkgs.fish
    
  ];
}
