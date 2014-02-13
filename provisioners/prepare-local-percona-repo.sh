#!/bin/bash

# This creates a local repo (CentOS/RHEL only for now) of all Percona software 
# for use in conferences and the like with poor internet connections
# This may also be handy for "freezing" on a specific version of software

# Goals here:
# - get every RPM currently in the percona repo
# - yum localinstall --download-only to get all deps too
# - set a local.repo, can be disabled via puppet if desired

importantpkgs=( "Percona-XtraDB-Cluster-full-56" "percona-xtrabackup" "Percona-Server-server-55" "Percona-Server-server-56" )
extrapkgs=( "haproxy" )

# This isn't perfect, but good enough for now
if [ -x /usr/bin/yum ]; then
	echo "CentOS"

	# Install a few yum plugins
	yum install -y yum-downloadonly yum-plugin-priorities createrepo yum-utils

	# Install percona repo
	yum localinstall -y http://www.percona.com/downloads/percona-release/percona-release-0.0-1.x86_64.rpm

	# Get (most) rpm packages from Percona repo
	mkdir -p /var/repo
	reposync -n --repoid=percona -p /var/repo

	# Clean out unnecessary packages
	rm -rf /var/repo/percona/*-50-*
	rm -rf /var/repo/percona/*-51-*
	rm -rf /var/repo/percona/Percona-XtraDB-Cluster-*-5.5.34-23*
	rm -rf /var/repo/percona/*-debuginfo-*
	rm -rf /var/repo/percona/*-test-*

	# Create local repo temporarily
	createrepo /var/repo
	echo "[local-repo]
gpgcheck=0
enabled=1
name=Local Repo
baseurl=file:///var/repo
priority=1" > /etc/yum.repos.d/local.repo


	mkdir -p /var/repo/extra
	# Use downloadonly to get all the deps for important packages
	for i in "${importantpkgs[@]}"
	do
		echo $i;
		yum install --downloadonly --downloaddir=/var/repo/extra -y $i
	done

	# Get extra packages
	for i in "${extrapkgs[@]}"
	do
		echo $i;
		yum install --downloadonly --downloaddir=/var/repo/extra -y $i
	done

	# Create disabled yum repo by default
	createrepo /var/repo
	echo "[local-repo]
gpgcheck=0
enabled=0
name=Local Repo
baseurl=file:///var/repo
priority=1" > /etc/yum.repos.d/local.repo

else
	echo -n "Unhandled OS: "
	cat /etc/issue
fi
