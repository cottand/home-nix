{ config, lib, pkgs, ... }: {
  programs.fish = {
    interactiveShellInit = ''
      source ${./ask_claude.fish}
    '';

    shellAbbrs."?" = {
      position = "command";
      function = "ask_claude";
    };

    shellAbbrs."ohno" = {
      position = "command";
      function = "fix_last_command";
    };
  };

  home.file.".claude/settings.json" = {
    source = ../../dotfiles;
    text = builtins.toJSON {
      includeCoAuthoredBy = false;
      permissions = {
        allow = [
          "Bash(git add:*)"
          "Bash(gh pr create)"
        ];
        deny = [ ];
      };
    };
    recursive = true;
  };
}
