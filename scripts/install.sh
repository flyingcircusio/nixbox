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
curl -f "$packer_http/vagrant.nix" > /mnt/etc/nixos/vagrant.nix
curl -f "$packer_http/configuration.nix" > /mnt/etc/nixos/configuration.nix
curl -f "$packer_http/vagrant-base.nix" > /mnt/etc/nixos/vagrant-base.nix

### Install ###
nixos-install

### Cleanup ###
curl "$packer_http/postinstall.sh" | nixos-install --chroot
