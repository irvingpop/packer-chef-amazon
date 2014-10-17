#!/bin/bash

if [ -x /usr/bin/yum ]; then
	echo "Yum"
  rpm -ivh http://mirrors.servercentral.net/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
	sudo yum -y upgrade
elif [ -x /usr/bin/apt-get ]; then
	echo "Apt"
	sudo apt-get update
	sudo apt-get upgrade -y
else
	echo -n "Unhandled OS: "
	cat /etc/issue
fi
