#!/usr/bin/env bash

export NIXOS_BUILD=$(curl -s --head https://hydra.flyingcircus.io/channels/branches/fc-15.09-production/ | \
    grep -i Location | \
    sed -E 's/.*15.09\.([0-9]+)\..*/\1/')


echo Building v$NIXOS_BUILD

exec packer build nixos-x86_64.json
