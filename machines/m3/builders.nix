{ ... }:

let
  arm = "aarch64-linux";
  x86_64 = "x86_64-linux";
  eligible = with builtins; attrValues (mapAttrs (name: hostKey: { inherit name hostKey; }) {
    # maco = x86_64;
    # cosmo = x86_64;
    # ari = x86_64;
    # xps2 = x86_64;
    miki = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSURObWcwYTVJZVFlOHNvOERza1JTbWFld0hzY0Y1L2lvYUNhYWhJZ1JkbzMgcm9vdEB2bWkxNzI2OTc0Cg==";
  });
in
{
  # emulate ARM - see https://colmena.cli.rs/unstable/examples/multi-arch.html
  # boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nix.buildMachines =
    builtins.map
      (
        { name, hostKey }: {
          hostName = "${name}.mesh.dcotta.eu";
          protocol = "ssh-ng";
          # if the builder supports building for multiple architectures, 
          # replace the previous line by, e.g.,
          systems = [ "x86_64-linux" "aarch64-linux" ];
          maxJobs = 2;
          speedFactor = 2;
          sshKey = "/Users/nico/.ssh/id_ed25519";
          sshUser = "root";
          publicHostKey = hostKey;
        }
      )
      eligible
  ;

  environment.etc = builtins.listToAttrs (map
    ({ name, hostKey }: {
      name = "ssh/ssh_config.d/200-${name}.conf";
      value.text = ''
        Host ${name}.mesh.dcotta.eu
          IdentitiesOnly yes
          IdentityFile /Users/nico/.ssh/id_ed25519
          HostKeyAlias ${name}.mesh.dcotta.eu
          User root

        Host ${name}.vps.dcotta.eu
          IdentitiesOnly yes
          IdentityFile /Users/nico/.ssh/id_ed25519
          HostKeyAlias ${name}.vps.dcotta.eu
          User root
      '';
    })
    eligible);

  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;
}
