#!/bin/bash

if [ -x /usr/bin/yum ]; then
	# Saves ~25M
	sudo yum -y remove kernel-devel
	# Clean cache
	sudo yum clean all
fi


if [ $PACKER_BUILDER_TYPE == "virtualbox-iso" ]
then
	# Clean up unused disk space so compressed image is smaller.
# Clean out all of the caching dirs
  sudo rm -rf /var/cache/* /usr/share/doc/*
	cat /dev/zero > /tmp/zero.fill
	rm /tmp/zero.fill
fi
