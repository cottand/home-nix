# https://nixos.wiki/wiki/Overlays
inputs:
final: prev:
let
  unstable = import inputs.nixpkgs-unstable pkgs-config;
  pkgs-config = {
    config.allowUnfree = true;
    system = prev.system;
  };
in
{
  # absolute latest nomad
  nomad_1_6 = unstable.nomad_1_6;

  # nix language server
  nixd = unstable.nixd;

  # jetbrains IDEs
  jetbrains = unstable.jetbrains;
}
