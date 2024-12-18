{ ... }: {
  environment.etc."ssh/ssh_config.d/20-nixbuild.conf".text = ''
    Host eu.nixbuild.net
      User root
      PubkeyAcceptedKeyTypes ssh-ed25519
      ServerAliveInterval 60
      IPQoS throughput
      IdentityFile /Users/nico/.ssh/nico-nixbuild-net
  '';

  nix = {
    # replace on builder
    extraOptions = ''
      builders-use-substitutes = false
    '';
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "eu.nixbuild.net";
        protocol = "ssh";
        system = "x86_64-linux";
        sshKey = "/Users/nico/.ssh/nico-nixbuild-net";
        sshUser = "root";
        maxJobs = 8;
        supportedFeatures = [ "benchmark" "big-parallel" ];
      }
    ];
  };
}
