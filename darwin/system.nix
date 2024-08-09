{ pkgs, ... }: {
  system.defaults = {
    ActivityMonitor.IconType = 5;
    NSGlobalDomain = {
      # CPU usage
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NSDocumentSaveNewDocumentsToCloud = false;
    };
    dock.autohide = true;
    dock.wvous-br-corner = 5;
    dock.mru-spaces = false;
    dock.show-recents = false;
    finder.ShowPathbar = true;
  };

  fonts.packages = with pkgs; [ dejavu_fonts fira-code-nerdfont ];

  security.pam.enableSudoTouchIdAuth = true;
}
