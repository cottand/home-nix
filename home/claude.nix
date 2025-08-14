{ config, lib, pkgs, ... }: {
  programs.fish = {
    interactiveShellInit = ''
      source ${./ask_claude.fish}
    '';

    shellAliases."?" = "ask_claude";
    shellAliases."ohno" = "fix_last_command";
  };

  home.file.".claude/settings.json" = {
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

  home.file.".claude/CLAUDE.md".source = ./CLAUDE.md;
}
