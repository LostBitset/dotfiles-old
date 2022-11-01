#!/bin/bash

# [LINKTO] !sudo bash -c 'echo -e "source $PWD/dotfiles/rc-local.sh\n" >> /etc/rc.local'

# Create a directory in /run/user for each user
# This is designed to be used as their $XDG_RUNTIME_DIR
cat /etc/passwd | awk -F ':' '{print $1}' | while read u; do
	dir="/run/user/$u"
	rm -rf $dir || true
	mkdir -p $dir
	chmod 700 $dir
	chown $u $dir
done

# Clear the console if the file /.supress-rclocal-clear doesn't exist
if [ -f /.supress-rclocal-clear ]; then
	echo "rc-local.sh: /.supress-rclocal-clear was found."
else
	clear
fi

