#!/bin/sh

sudo yum install -y lvm2 || exit 1
sudo chkconfig lvm2-lvmetad on || exit 1
