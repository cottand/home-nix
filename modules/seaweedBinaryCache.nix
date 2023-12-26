{ lib, config, ... }:
##
# Enables use of seaweedfs bucket as an S3 Nix binary cache
# 
# Machines can push builds (via nix store copy or via this post-build hook) or
# use the cache as a substituter to pull cached built NARs
##
with lib;
let
  cfg = config.cottand.seaweedBinaryCache;
in
{
  # config
  options.cottand.seaweedBinaryCache = {
    uploadPostBuild = mkOption {
      type = types.bool;
      default = false;
    };

    useSubstituter = mkOption {
      type = types.bool;
      default = false;
    };

    cacheUrl = mkOption {
      type = types.str;
      default = "s3://nix-cache?profile=cache-upload&endpoint=seaweedfs-filer-s3.traefik&scheme=http";
    };
  };


  # implementation
  config =
    (mkIf cfg.uploadPostBuild {
      nix.extraOptions = "post-build-hook = /etc/nix/scripts/upload-to-cache.sh";
      environment.etc."nix/scripts/upload-to-cache.sh" = {
        source = ./../scripts/upload-to-cache.sh;
        mode = "0555";
      };
    })
    //
    (mkIf cfg.useSubstituter {
      nix.settings.substituters = [ cfg.cacheUrl ];
    });
}
