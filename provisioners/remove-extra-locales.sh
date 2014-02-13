#!/bin/bash		

# Manually delete all but en_US locales
find /usr/share/locale -maxdepth 1 -mindepth 1 -type d | grep -v -e "en_US" | xargs rm -rf

# Delete unused locales from local-archive
localedef --list-archive | grep -v -e "en_US" | xargs localedef --delete-from-archive
mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl
build-locale-archive

