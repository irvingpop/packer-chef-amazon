

cat > /tmp/cloud.cfg <<EOF
users:
 - default

disable_root: 0
ssh_pwauth:   0

preserve_hostname: 1

locale_configfile: /etc/sysconfig/i18n
mount_default_fields: [~, ~, 'auto', 'defaults,nofail', '0', '2']
resize_rootfs_tmp: /dev
ssh_deletekeys:   0
ssh_genkeytypes:  ~
syslog_fix_perms: ~

cloud_init_modules:
 - bootcmd
 - write-files
 - growpart
 - resizefs
 - set_hostname
 - update_hostname
 - update_etc_hosts
 - rsyslog
 - users-groups
 - ssh

cloud_config_modules:
 - mounts
 - locale
 - set-passwords
 - yum-add-repo
 - package-update-upgrade-install
 - timezone
 - puppet
 - chef
 - salt-minion
 - mcollective
 - disable-ec2-metadata
 - runcmd

cloud_final_modules:
 - rightscale_userdata
 - scripts-per-once
 - scripts-per-boot
 - scripts-per-instance
 - scripts-user
 - ssh-authkey-fingerprints
 - keys-to-console
 - phone-home
 - final-message

system_info:
  distro: rhel
  default_user:
    name: ec2-user
    lock_passwd: true
    gecos: Cloud User
    groups: [wheel, adm]
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/bash
  distro: rhel
  paths:
    cloud_dir: /var/lib/cloud
    templates_dir: /etc/cloud/templates
  ssh_svcname: sshd

datasource:
  Ec2:
    timeout: 10
    max_wait: 30

# vim:syntax=yaml
EOF

sudo mv /etc/cloud/cloud.cfg /etc/cloud/cloud.cfg.orig
sudo mv /tmp/cloud.cfg /etc/cloud/cloud.cfg

# # failsafe because cloud-init is silly
# echo "`whoami` ALL=(ALL) NOPASSWD:ALL" > /tmp/10-cloud-init-hates-me
# sudo cp /tmp/10-cloud-init-hates-me /etc/sudoers.d/
# sudo cat /etc/sudoers.d/10-cloud-init-hates-me

# # grab the latest cloud-init from CentOS
# sudo yum -y install cloud-init || exit 1
