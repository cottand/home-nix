{
  home.file.".ideavimrc" = {
    text = ''
      " Show a few lines of context around the cursor. Note that this makes the
      " text scroll if you mouse-click near the start or end of the window.
      set scrolloff=5

      " Space is the leader
      let mapleader = " "

      set incsearch

      "" -- Map IDE actions to IdeaVim -- https://jb.gg/abva4t
      map <leader>f <Action>(ReformatCode)
      map <leader>d <Action>(Run)

      map <leader>r <Action>(RenameElement)
      map <leader>i <Action>(Inline)
      map <leader>F <Action>(GotoFile)
      map <leader>A <Action>(GotoAction)
      map <leader>og <Action>(Github.Open.In.Browser)
      map <leader>op <Action>(RecentProjectListGroup)
      map <leader>ob <Action>(Git.Branches)


      "" Map \b to toggle the breakpoint on the current line
      "map \b <Action>(ToggleLineBreakpoint)

      " Share clipboard with system
      set clipboard+=unnamed

      " Ignore case by default when searching, unless any char is uppercase
      set ignorecase
      set smartcase
      " Highlight search results
      set hlsearch
      " Do incremental searching.
      set incsearch


      set highlightedyank

      " Requires plugin installed
      set which-key

      " which-key timeout=4s
      set timeoutlen=4000
      let g:WhichKey_ShowVimActions = "true"


      " Find more examples here:
      " - https://jb.gg/share-ideavimrc
      " - https://www.cyberwizard.io/posts/the-ultimate-ideavim-setup/
    '';
  };

}