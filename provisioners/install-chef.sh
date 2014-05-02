#!/bin/bash

echo "Installing chef"

if [ -x /usr/bin/yum ]; then
  curl -L https://www.opscode.com/chef/install.sh | sudo bash
elif [ -x /usr/bin/apt-get ]; then
  curl -L https://www.opscode.com/chef/install.sh | sudo bash
else
	echo -n "Unhandled OS: "
	cat /etc/issue
fi
