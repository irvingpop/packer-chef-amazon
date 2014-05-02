#!/bin/bash

if [ -f /etc/selinux/config ]; then
	sudo sed -i "s/enforcing/permissive/" /etc/selinux/config
fi

sudo service iptables stop
sudo chkconfig iptables off