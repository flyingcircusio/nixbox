# Base configuration used for installing the system. It will be overwritten
# during building the box.
{ ... }:
{
    imports = [
        ./hardware-configuration.nix
        ./vagrant-base.nix
        ./vagrant.nix];
}
