#!/bin/sh

echo 'Removing root authorized_keys so EC2 will auto-populate it'
sudo rm -f /root/.ssh/authorized_keys

cat > /tmp/cloud.cfg <<EOF
cloud_type: auto
user: ec2-user
disable_root: 0
preserve_hostname: False
EOF

sudo mv /tmp/cloud.cfg /etc/cloud/cloud.cfg
