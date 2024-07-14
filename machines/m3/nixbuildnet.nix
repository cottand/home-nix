{ ... }: {
  environment.etc."ssh/ssh_config.d/300-nixbuild.conf".text = ''
    Host eu.nixbuild.net
      PubkeyAcceptedKeyTypes ssh-ed25519
      ServerAliveInterval 60
      IPQoS throughput
      IdentityFile /Users/nico/.ssh/id_ed25519
  '';

  programs.ssh.knownHosts = {
    nixbuild = {
      hostNames = [ "eu.nixbuild.net" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
    };
  };

  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "eu.nixbuild.net";
        system = "x86_64-linux";
        sshKey = "/Users/nico/.ssh/id_ed25519";
        maxJobs = 10;
        supportedFeatures = [ "benchmark" "big-parallel" ];
      }
    ];
  };
}
