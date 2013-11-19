#!/bin/bash		

if [ -x /usr/bin/yum ]; then
	echo "Yum"
	yum -y upgrade
elif [ -x /usr/bin/apt-get ]; then
	echo "Apt"
	apt-get update
	apt-get upgrade -y
else
	echo -n "Unhandled OS: "
	cat /etc/issue
fi
