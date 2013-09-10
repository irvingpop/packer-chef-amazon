#!/bin/sh

# This creates a local repo (CentOS/RHEL only for now) of all Percona software 
# for use in conferences and the like with poor internet connections
# This may also be handy for "freezing" on a specific version of software

# Goals here:
# - get every RPM currently in the percona repo
# - yum localinstall --download-only to get all deps too
# - set a local.repo, can be disabled via puppet if desired

extrapkgs=( "haproxy" )

# This isn't perfect, but good enough for now
grep CentOS /etc/issue > /dev/null
if [ $? ]; then
	echo "CentOS"

	# Install a few yum plugins
	yum install -y yum-downloadonly yum-plugin-priorities createrepo

	# Create a local repo
	mkdir -p /var/repo

	# Get (most) rpm packages from Percona repo
	wget -nv -P /var/repo -r -np -nH --cut-dirs=4 -A '*.rpm' -R '*debuginfo*' -R '*test*' -nc http://repo.percona.com/centos/6/os/x86_64/ 2> /dev/null

	# Use downloadonly to get all the deps for every package
	ls /var/repo/*.rpm | xargs -n1 yum install --downloadonly --downloaddir=/var/repo -y

	# Get extra packages
	for i in "${extrapkgs[@]}"
	do
		echo $i;
		yum install --downloadonly --downloaddir=/var/repo -y $i
	done

	# Create repo metadata
	createrepo /var/repo

	# Setup yum repo
	echo "[local-repo]
gpgcheck=0
name=Local Repo
baseurl=file:///var/repo
priority=1" > /etc/yum.repos.d/local.repo

else
	echo -n "Unhandled OS: "
	cat /etc/issue
fi
