#!/bin/bash

# DOTFILE: /etc/rc.local
# >>>>>>>> #!/bin/bash
# >>>>>>>> <initial contents>
# >>>>>>>> source <repo>/dotfiles/rc-local.sh

# Create a directory in /run/user for each user
# This is designed to be used as their $XDG_RUNTIME_DIR
cat /etc/passwd | awk -F ':' '{print $1}' | while read u; do
	dir="/run/user/$u"
	rm -rf $dir || true
	mkdir -p $dir
	chmod 700 $dir
	chown $u $dir
done

