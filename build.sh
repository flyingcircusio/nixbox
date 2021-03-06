#!/usr/bin/env bash

url=$(curl -Ls -o /dev/null -w %{url_effective} https://hydra.flyingcircus.io/job/flyingcircus/fc-20.09-dev/images.vagrant/latest/download-by-type/file/ova)
filename=$(basename $url)
NIXOS_BUILD=$(sed -E 's/.*20.09\.([0-9]+)\..*/\1/' <<< "$filename")
NIXOS_REV=$(sed -E 's/.*20.09\.[0-9]+\.([0-9a-z]+).*/\1/' <<< "$filename")
BOX_VERSION="$NIXOS_BUILD.$NIXOS_REV"

echo Latest vagrant image is $BOX_VERSION

if curl -s -f -I https://app.vagrantup.com/flyingcircus/boxes/nixos-20.09-dev-x86_64/versions/$BOX_VERSION > /dev/null; then
	echo "Image already uploaded to Vagrant Cloud."
	exit 0;
fi

rm -f source.ova
curl -o source.ova $url

export PACKER_LOG=1
#exec packer build -on-error=ask -debug -var "version=$BOX_VERSION" nixos-20.09-x86_64-ova.json
exec packer build -var "version=$BOX_VERSION" nixos-20.09-x86_64-ova.json
