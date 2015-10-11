#!/bin/sh

echo Running $0

mkdir -p /run/user/0/

# Make sure we are totally up to date
nix-channel --remove nixos
nix-channel --add http://cecil.theune.cc/channels/branches/fc-15.09-dev nixos
nix-channel --update

cp /nix/var/nix/profiles/per-user/root/channels/nixos/nixos/modules/flyingcircus/bootstrap-config.nix  /etc/nixos/configuration.nix

nixos-rebuild switch --upgrade

# Cleanup any previous generations and delete old packages that can be
# pruned.

for x in $(seq 0 2) ; do
  nix-env --delete-generations old
  nix-collect-garbage -d
done


# Remove install ssh key
rm -rf /root/.ssh /root/.packer_http

# Zero out the disk (for better compression)
echo Zeroing out disk ...
dd if=/dev/zero of=/EMPTY bs=1M
rm -rf /EMPTY
