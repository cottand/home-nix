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
  nomad_1_7 = unstable.nomad_1_7;
  nomad = final.nomad_1_7;

  # nix language server
  nixd = unstable.nixd;

  # jetbrains IDEs
  jetbrains = unstable.jetbrains;

  # gnome = prev.gnome.overrideScope' (pself: psuper: {
  #   mutter = psuper.mutter.overrideAttrs (oldAttrs: {
  #     src = prev.fetchurl {
  #       url = "https://gitlab.gnome.org/vanvugt/mutter/-/archive/triple-buffering-v4/mutter-triple-buffering-v4.tar.gz?sha=51f96d2a7b8128fb0b674aaeadc8d082145e73aa";
  #       # url = ""
  #       hash = "sha256-O7mqzU8qlclY70pDy9hAryIeOzrNlDjPm9NUzL/Ltq4=";
  #     };
  #   });
  # });
  # gnome = prev.gnome.overrideScope' (pself: psuper: {
  #   mutter = psuper.mutter.overrideAttrs (oldAttrs: {
  #     patches = (oldAttrs.patches or [ ]) ++ [
  #       (prev.fetchpatch {
  #         url = "https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/1441.patch";
  #         hash = "sha256-5r4UP4njxrfRebItzQBPrTKaPUzkWA+9727YdWgBCpA=";
  #         # revert = true;
  #       })
  #     ];
  #   });
  # });
}
