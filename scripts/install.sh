#!/bin/sh -e

packer_http=$(cat .packer_http)

# Partition disk
cat <<FDISK | fdisk /dev/sda
n




a
w

FDISK

# Create filesystem
mkfs.ext4 -j -L nixos /dev/sda1

# Mount filesystem
mount LABEL=nixos /mnt

# Setup system
nixos-generate-config --root /mnt

echo Copying FCIO configuration
cp /nix/var/nix/profiles/per-user/root/channels/nixos/nixos/modules/flyingcircus/bootstrap-config.nix  /mnt/etc/nixos/configuration.nix
curl -f "$packer_http/vagrant.nix" > /mnt/etc/nixos/vagrant.nix


echo Starting nixos-install
### Install ###
nixos-install

### Cleanup ###
curl "$packer_http/postinstall.sh" | nixos-install --chroot
