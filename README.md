# Packer Percona

The goal of these packer builds is to create consistent Vagrant boxes across multiple vagrant providers, specifically for Percona vagrant usage.  Currently only Virtualbox and EC2 are supported.

These setups are typically for the purposes of internal testing and demonstration purposes and don't necessarily reflect recommended production settings.  

## Setup

* Packer 0.1.4+: http://packer.io
* AWS account with standard access credentials: http://aws.amazon.com (optional)
* Virtualbox http://virtualbox.org (optional)
* Vagrant: http://vagrantup.com

### AWS

Put your access and secret keys in environment variables in your .bashrc or similar (for packer):

```bash
export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=THE_ASSOCIATED_SECRET_KEY
```


## Building

Currently only CentOS 6 is up to date.  Ubuntu and other Linux types are feasible with Packer.

* Modify centos6.json as desired
 * Source AMI
 * Region

```bash
packer validate centos-6_4-64.json
packer build centos-6_4-64.json
vagrant box add centos-6_4-64_percona centos-6_4-64_percona_virtualbox.box
vagrant box add centos-6_4-64_percona centos-6_4-64_percona_aws.box
cd ..
```

This will add boxes for each of the providers packer builds a box for.  You can optionally just build a box for specific provider like this:

```bash
packer build --only=amazon-ebs centos-6_4-64.json
```


## Nuances

* These boxes assume Vagrant is logging in with 'root', not 'vagrant'.
* These boxes should be updated to the latest package releases on build
* An extra device or logical volume is available (and possibly setup) for /var/lib/mysql 


## OSes

### CentOS 6 builds

The VM-based builds use a netinstall ISO and a kickstart file to provision the box.   This guarantees all packages are up to date at the time of the build.

AWS uses an official CentOS 6 AMI "with Updates".  http://wiki.centos.org/Cloud/AWS  These are Region-specific, so you'll need a different AMI identifier for different AWS regions.

### Ubuntu 

Needs work

### ???

## Providers

### Virtualbox

Local VM -- a favorite for conference tutorials.  

http://virtualbox.org

### Amazon EC2 - EBS AMI

Creates an EBS-based AMI associated with a specific AWS Region.  

### ???