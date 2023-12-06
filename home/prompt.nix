{ ... }: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = rec {
      package.disabled = true;

      git_branch.style = "bold green";
      git_status = {
        style = git_branch.style;
        format = "([$all_status$ahead_behind]($style) )";
        # adds $count to git_status indicators
        ahead = "\${count}⇡";
        diverged = "⇕\${ahead_count}⇡\${behind_count}⇣";
        behind = "\${count}⇣";
        stashed = "\${count}≡"; # 
      };

      # https://starship.rs/config/#aws
      aws.disabled = true;

      # sets nerd font symbols in prompt - see https://starship.rs/presets/nerd-font.html
      aws.symbol = "  ";
      buf .symbol = " ";
      c.symbol = " ";
      conda.symbol = " ";
      dart.symbol = " ";
      directory.read_only = " 󰌾";
      docker_context.symbol = " ";
      git_branch.symbol = " ";
      golang.symbol = " ";
      hostname.ssh_symbol = " ";
      java.symbol = " ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      os.symbols = {
        Alpaquita = " ";
        Alpine = " ";
        Amazon = " ";
        Android = " ";
        Arch = " ";
        Artix = " ";
        CentOS = " ";
        Debian = " ";
        DragonFly = " ";
        Emscripten = " ";
        EndeavourOS = " ";
        Fedora = " ";
        FreeBSD = " ";
        Garuda = "󰛓 ";
        Gentoo = " ";
        HardenedBSD = "󰞌 ";
        Illumos = "󰈸 ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Manjaro = " ";
        Mariner = " ";
        MidnightBSD = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        OpenBSD = "󰈺 ";
        openSUSE = " ";
        OracleLinux = "󰌷 ";
        Pop = " ";
        Raspbian = " ";
        Redhat = " ";
        RedHatEnterprise = " ";
        Redox = "󰀘 ";
        Solus = "󰠳 ";
        SUSE = " ";
        Ubuntu = " ";
        Unknown = " ";
        Windows = "󰍲 ";
      };

      package.symbol = "󰏗 ";
      python.symbol = " ";
      ruby.symbol = " ";
    };
  };
}
