# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Added: environment variables

export PATH="$PATH:/home/$(whoami)/.local/bin:/home/$(whoami)/AppsDownloaded/bin:/home/hkt/config_own/bin"

export XDG_CONFIG_HOME="/home/$(whoami)/.config"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# Added: why have a splash screen when neofetch exists

if [[ $(tty) == "/dev/tty1" ]]
then
	clear
	xbps-install -S # Synchronize all repos

	clear
	neofetch

	read -p "Would you like to start the X server? [Y/n]: "

	if [[ $REPLY == "" ]]
		then startx
	elif [[ $REPLY == "y" ]]
		then startx
	elif [[ $REPLY == "n" ]]
		then clear
	else
		echo "Invalid option."
		echo "Dropping you back into the shell..."
		sleep 1
		clear
	fi

fi

# Added: Set a simple title for terminal emulators

if [[ "$TERM" == "xterm-256color" ]]
then
	terminalcount=`expr $(ps aux | grep -v sh | grep Terminal | wc -l) - 1`
	echo -ne "\033]0;Terminal (#$terminalcount)\007"
	clear
fi

# Automatically generated from opam installation
# Makes OCaml work

# opam configuration
test -r /home/hkt/.opam/opam-init/init.sh && . /home/hkt/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# Make golang work
# Just adds to the PATH
export PATH=$PATH:/usr/local/go/bin

