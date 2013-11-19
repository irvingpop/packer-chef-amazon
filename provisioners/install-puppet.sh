#!/bin/bash

echo "Installing puppet"

if [ -x /usr/bin/yum ]; then
	yum localinstall -y http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
	yum install -y puppet
elif [ -x /usr/bin/apt-get ]; then
	apt-get install puppet -y
else
	echo -n "Unhandled OS: "
	cat /etc/issue
fi
