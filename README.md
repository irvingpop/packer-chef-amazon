# Packer 

The goal of these packer builds is to create consistent Vagrant boxes across multiple vagrant providers.  Currently only Virtualbox and EC2 are supported.

## Nuances

* These boxes assume Vagrant is logging in with 'root', not 'vagrant'.
* These boxes should be updated to the latest package releases on build
* An extra device or logical volume is available (and possibly setup) for /var/lib/mysql 

## CentOS 6 builds

The VM-based builds use a netinstall ISO and a kickstart file to provision the box.   This guarantees all packages are up to date at the time of the build.

AWS uses an official CentOS 6 AMI "with Updates".  http://wiki.centos.org/Cloud/AWS  These are Region-specific, so you'll need a different AMI identifier for different AWS regions.