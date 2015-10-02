Flying Circus NixOS boxes for Vagrant
=====================================

This is the builder for the NixOS base box for vagrant containing Flying Circus specifics

[NixOS](http://nixos.org) is a linux distribution based on a purely functional
package manager. This project builds [vagrant](http://vagrantup.com) .box
images.

Usage
-----

XXX install nixos plugin

```
vagrant init flyingcircus/nixos-15.09-x86_64
```


Building the images
-------------------

First install [packer](http://packer.io) and [virtualbox](https://www.virtualbox.org/)

Then:

```
packer build nixos-x86_64.json
```

The .box image is now ready to go and you can use it in vagrant:

```
vagrant box add nixbox32 packer_virtualbox-iso_virtualbox.box
# or
vagrant box add nixbox64 packer_virtualbox-iso_virtualbox.box
```

License
-------

Copyright 2014 under the MIT

