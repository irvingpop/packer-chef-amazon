echo "Removing ephemeral mounts from fstab"
sudo sed -i "s/.*ephemeral.*//g" /etc/fstab

echo "Replacing /etc/sysconfig/cloudinit"
cat > /tmp/cloudinit.sysconfig <<EOF
CONFIG_SSH=yes
CONFIG_MOUNTS=no
PACKAGE_SETUP=yes
RUNCMD=yes
RUN_USER_SCRIPTS=yes
PUPPET=no
CONFIG_LOCALE=yes
EOF

sudo mv /tmp/cloudinit.sysconfig /etc/sysconfig/cloudinit