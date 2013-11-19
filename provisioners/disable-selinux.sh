#!/bin/bash		

if [ -f /etc/selinux/config ]; then
	sed -i "s/enforcing/permissive/" /etc/selinux/config
fi