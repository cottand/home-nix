{ ... }: {

  programs.git = {
    enable = true;
    userName = "Cottand";
    userEmail = "nico.dc@outlook.com";
    aliases = {
      ac = "!git add . && git commit -m";
      co = "checkout";
      s = "status";
      ps = "push";
      pl = "pull";
      d = "diff";
      f = "fetch";
      st = "stash";
      sp = "stash pop";
      yolo = "commit --amend -a --no-edit";
    };
  };

  home.shellAliases = {
    g = "git";
  };
}
