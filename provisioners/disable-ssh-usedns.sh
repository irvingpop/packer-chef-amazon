#!/bin/bash		

if [ -f /etc/ssh/sshd_config ]; then
	sed -i "s/#UseDNS yes/UseDNS no/" /etc/ssh/sshd_config
fi
