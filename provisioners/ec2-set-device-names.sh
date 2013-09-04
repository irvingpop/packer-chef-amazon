#!/bin/sh

echo "options xen_blkfront sda_is_xvda=1" > /etc/modprobe.d/xen_blkfront.conf
sed -i 's/xvde/xvda/' /etc/fstab
