{ config, lib, pkgs, ... }: {
  programs.fish = {
    interactiveShellInit = ''
      source ${./ask_claude.fish}
    '';

    shellAliases."?" = "ask_claude";
    shellAliases."ohno" = "fix_last_command";
  };


  home.file.".claude/agents/mlstruct-expert.md" = {
    source = ./claude/mlstruct-expert.md;
  };


  home.file.".claude/CLAUDE.md".source = ./CLAUDE.md;
}
