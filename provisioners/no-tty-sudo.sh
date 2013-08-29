#!/bin/bash

# Sudo -> don't require tty
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers