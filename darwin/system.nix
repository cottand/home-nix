{ pkgs, ... }: {
  system.defaults = {
    ActivityMonitor.IconType = 5;
    dock.autohide = true;
    NSGlobalDomain = {
      # CPU usage
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NSDocumentSaveNewDocumentsToCloud = false;
    };
  };


  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ dejavu_fonts fira-code-nerdfont ];
  };

}
