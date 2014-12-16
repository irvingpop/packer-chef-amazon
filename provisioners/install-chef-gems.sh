#!/bin/bash

echo "Installing chef gems"

if [ -x /usr/bin/yum ]; then
  sudo /usr/bin/yum install -y gcc libxml2-devel libxslt-devel vim telnet nc gdisk cloud-utils-growpart || exit 1
elif [ -x /usr/bin/apt-get ]; then
  echo "TODO: do stuff here"
else
  echo -n "Unhandled OS: "
  cat /etc/issue
fi

sudo /opt/chef/embedded/bin/gem install --no-rdoc --no-ri nokogiri -v '1.6.3.1' -- --use-system-libraries
sudo /opt/chef/embedded/bin/gem install --no-rdoc --no-ri fog
sudo /opt/chef/embedded/bin/gem install --no-rdoc --no-ri aws-sdk
sudo /opt/chef/embedded/bin/gem install --no-rdoc --no-ri right_aws
