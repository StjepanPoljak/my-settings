tty | grep '^\/dev\/tty[0-9]\+$' > /dev/null
TTY_BOOL="$?"

TZ='Europe/Belgrade'; export TZ

PATH=$PATH:/home/stjepan/.local/bin

if [ -z "$DISPLAY" ] && [ "$TTY_BOOL" -eq 0 ]; then
	exec startx
fi
