#!/bin/bash		

# This isn't perfect, but good enough for now
grep CentOS /etc/issue > /dev/null
if [ $? ]; then
	echo "CentOS"
	yum -y upgrade
else
	echo -n "Unhandled OS: "
	cat /etc/issue
fi
