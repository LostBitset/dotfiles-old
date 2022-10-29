#!/bin/bash

for FILE in ./dotfiles/*; do
	LINK_TARGET_LINE=$(cat $FILE | grep "\[LINKTO\]")
	LINK_TARGET_DIRECTIVE=$(echo $LINK_TARGET_LINE | sed 's/^.*\[LINKTO\] //')
	case "${LINK_TARGET_DIRECTIVE:0:1}" in
		"~")
			LINK_TARGET="$HOME${LINK_TARGET_DIRECTIVE:1}"
			echo -n "Link: $LINK_TARGET -> $FILE..."
			rm $LINK_TARGET
			ln -s "$PWD/$FILE" "$LINK_TARGET"
			;;
		"!")
			LINK_COMMAND="${LINK_TARGET_DIRECTIVE:1}"
			echo -n "Run: $LINK_COMMAND..."
			eval "$LINK_COMMAND"
			;;
		*)
			echo "ERROR: Unknown start character in ${LINK_TARGET_DIRECTIVE}."
			exit
			;;
	esac
	if cat $FILE | grep "\[LINKEXEC\]" >/dev/null; then
		echo -n " (exec)..."
		chmod +x $FILE
	fi
	echo "done"
done

