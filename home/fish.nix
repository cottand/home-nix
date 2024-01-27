{ pkgs, ... }: {

  home.packages = [ pkgs.grc ];
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      export EDITOR="${pkgs.vim}/bin/vim"
      export SHELL="${pkgs.fish}/bin/fish"
    '';
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "bass"; src = pkgs.fishPlugins.bass.src; }
    ];

    shellAbbrs = {
      "rebuild" = "darwin-rebuild switch --flake ~/dev/cottand/home-nix";
      "~cottand" = "~/dev/cottand/";
      "!!" = {
        position = "anywhere";
        function = "last_history_item";
      };
      "devc" = {
        position = "anywhere";
        setCursor = "!";
        expansion = "~/dev/cottand/!";
      };
    };
  };
}
