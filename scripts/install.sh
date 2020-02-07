#!/bin/sh -e

mkdir -p /run/user/0/

# Cleanup any previous generations and delete old packages that can be
# pruned.

for x in $(seq 0 2) ; do
  nix-env --delete-generations old
  nix-collect-garbage -d
done

# Zero out the disk (for better compression)
echo Zeroing out disk ...
dd if=/dev/zero of=/EMPTY bs=1M || true
rm -rf /EMPTY
