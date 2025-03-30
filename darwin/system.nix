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

  fonts.packages = with pkgs; [ dejavu_fonts nerd-fonts.fira-code ];

  security.pam.services.sudo_local.touchIdAuth = true;
}
