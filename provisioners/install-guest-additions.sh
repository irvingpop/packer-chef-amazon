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

elif [ $PACKER_BUILDER_TYPE == "amazon-ebs" ]
then
	echo "No extensions for EC2"

else
	echo "No extensions defined for $PACKER_BUILDER_TYPE"
fi