#!/bin/sh

# shamelessly stolen from (has MIT licence)
# https://github.com/nrdxp/nrdos/blob/fa03b1dc69060a57b288e492c86d34ec8c92d24e/src/nrdos/upload-to-cache.sh

# set -u

# KEY="/run/keys/cache.nrdxp.dev"
STORE="s3://nix-cache?profile=cache-upload&endpoint=seaweedfs-filer-s3.traefik&scheme=http"

# GITHUB CI
if [ -d ~runner ]; then
  # uploading handled explicitly in CI
  exit 0
  # TMPDIR=$(cat ~runner/.cache_dir)
  # NIX="$(cat "$TMPDIR"/.nix)"

  # PATH="$(dirname "$NIX"):$PATH"
  # unset NIX

  # KEY="$TMPDIR/.nix-key"

  # export PATH
fi

# set -eu
set -u

  if [ -n "$OUT_PATHS" ]; then
    # send copy operations to a task queue so the next build can start
    nix run nixpkgs#ts -- nix copy --to "$STORE" "$OUT_PATHS" || {
      echo "No 'nixpkgs' registry pin..."
      exit 0
    }
  else
    # this can happen if we are just using `nix build --rebuild` to check a package
    echo "Nothing to upload"
  fi
