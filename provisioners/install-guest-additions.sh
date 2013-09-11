#!/bin/bash

if [ $PACKER_BUILDER_TYPE == "virtualbox" ]
then
	echo "Installing Vbox Guest Extensions"	
	# Mount the disk image
	cd /tmp
	mkdir /tmp/isomount
	mount -t iso9660 -o loop /root/VBoxGuestAdditions.iso /tmp/isomount

	# Install the drivers
	/tmp/isomount/VBoxLinuxAdditions.run

	# Cleanup
	umount isomount
	rm -rf isomount /root/VBoxGuestAdditions.iso

elif [ $PACKER_BUILDER_TYPE == "vmware" ]
then
	echo "Installing VMware Guest Additions"

	# Make sure perl is available
	yum -y install perl

	# Mount the disk image
	cd /tmp
	mkdir /tmp/isomount
	mount -t iso9660 -o loop /root/linux.iso /tmp/isomount

	# Install the drivers
	cp /tmp/isomount/VMwareTools-*.gz /tmp
	tar -zxvf VMwareTools*.gz
	./vmware-tools-distrib/vmware-install.pl -d

	# Cleanup
	umount isomount
	rm -rf isomount /root/linux.iso VMwareTools*.gz vmware-tools-distrib

elif [ $PACKER_BUILDER_TYPE == "amazon-ebs" ]
then
	echo "No extensions for EC2"

else
	echo "No extensions defined for $PACKER_BUILDER_TYPE"
fi