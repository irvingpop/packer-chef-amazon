#!/bin/bash		

if [ -x /usr/bin/yum ]; then
	# Saves ~25M
	yum -y remove kernel-devel
	# Clean cache
	yum clean all
fi

# Clean out all of the caching dirs
rm -rf /var/cache/* /usr/share/doc/*

if [ $PACKER_BUILDER_TYPE == "virtualbox-iso" ]
then
	# Clean up unused disk space so compressed image is smaller.
	cat /dev/zero > /tmp/zero.fill
	rm /tmp/zero.fill
fi
