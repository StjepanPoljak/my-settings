tty | grep '^\/dev\/tty[0-9]\+$' > /dev/null
TTY_BOOL="$?"

if [ -z "$DISPLAY" ] && [ "$TTY_BOOL" -eq 0 ]; then
	exec startx
fi
