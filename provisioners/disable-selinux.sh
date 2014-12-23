#!/bin/bash

if [ -f /etc/selinux/config ]; then
	sudo sed -i "s/enforcing/permissive/" /etc/selinux/config
fi

RHEL7=`grep "release 7" /etc/redhat-release`

if [ -n "${RHEL7}" ]; then
  echo "RHEL7 detected: ${RHEL7}"
else
  sudo service iptables stop
  sudo chkconfig iptables off
fi
