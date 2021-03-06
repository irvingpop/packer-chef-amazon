#!/bin/bash

if [ -x /usr/bin/yum ]; then
	echo "Yum"
  if ! [ -L /boot/grub/menu.lst ]; then
    echo "Fixing bashton image bug where menu.lst doesnt get updated"
    sudo rm /boot/grub/menu.lst || exit 1
    sudo ln -s /boot/grub/grub.conf /boot/grub/menu.lst || exit 1
  fi

  # upgrades
	sudo yum -y upgrade || exit 1
elif [ -x /usr/bin/apt-get ]; then
	echo "Apt"
	sudo apt-get update
	sudo apt-get upgrade -y
else
	echo -n "Unhandled OS: "
	cat /etc/issue
fi
