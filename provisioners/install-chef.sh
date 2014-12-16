#!/bin/bash

echo "Installing chef"

if [ -x /usr/bin/yum ]; then
  curl -L https://www.getchef.com/chef/install.sh | sudo bash -s
  # curl -L https://www.getchef.com/chef/install.sh | sudo bash -s -- -p
elif [ -x /usr/bin/apt-get ]; then
  curl -L https://www.getchef.com/chef/install.sh | sudo bash -s
  # curl -L https://www.getchef.com/chef/install.sh | sudo bash -s -- -p
else
	echo -n "Unhandled OS: "
	cat /etc/issue
fi
