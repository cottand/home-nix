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

          "Bash(git checkout master)"
          "Bash(git pull master:*)"

          "Bash(gh pr create --draft :*)"
          "Bash(gh pr diff:*)"
        ];
        deny = [ ];
      };
    };
  };


  home.file.".claude/CLAUDE.md".source = ./CLAUDE.md;
}
