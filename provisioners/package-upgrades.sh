#!/bin/bash		

if [ -x /usr/bin/yum ]; then
	echo "Yum"
	sudo yum -y upgrade
elif [ -x /usr/bin/apt-get ]; then
	echo "Apt"
	sudo apt-get update
	sudo apt-get upgrade -y
else
	echo -n "Unhandled OS: "
	cat /etc/issue
fi
