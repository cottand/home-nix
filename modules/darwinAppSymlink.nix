{ config, lib, pkgs, ... }:

# see https://github.com/nix-community/home-manager/issues/1341#issuecomment-1870352014
with lib;
{
  config = mkIf pkgs.stdenv.hostPlatform.isDarwin {
    # Install MacOS applications to the user Applications folder. Also update Docked applications
    home.extraActivationPath = with pkgs; [
      rsync
      dockutil
      gawk
    ];


    home.activation.trampolineApps = hm.dag.entryAfter [ "writeBoundary" ] ''
      ${builtins.readFile ./scripts/trampoline-apps.sh}
      fromDir="$HOME/Applications/Home Manager Apps"
      toDir="$HOME/Applications/Home Manager Trampolines"
      sync_trampolines "$fromDir" "$toDir"
    '';
  };
}
