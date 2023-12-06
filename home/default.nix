{ ... }: {

  imports = [
    ./gnome-dconf.nix
    ./fish.nix
    ./prompt.nix
    ./shell.nix
  ];


  home.file.".ideavimrc" = {
    text = ''
      " Show a few lines of context around the cursor. Note that this makes the
      " text scroll if you mouse-click near the start or end of the window.
      set scrolloff=5

      " Do incremental searching.
      set incsearch

      " Don't use Ex mode, use Q for formatting.
      map Q gq

      "" -- Map IDE actions to IdeaVim -- https://jb.gg/abva4t
      map gf <Action>(ReformatCode)

      map gr <Action>(Run)
      "" Map \b to toggle the breakpoint on the current line
      "map \b <Action>(ToggleLineBreakpoint)


      " Find more examples here: https://jb.gg/share-ideavimrc
    '';
  };

  home.stateVersion = "22.11";
}
