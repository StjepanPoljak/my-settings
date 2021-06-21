#!/bin/bash

while IFS="" read -r CURR || [ -n "$CURR" ]
do
	SRC="/home/$USER/$CURR"
	DEST="$(pwd)/$CURR"
	DIFF="`diff "$SRC" "$DEST"`"

	if ! [ -z "$DIFF" ]; then
		echo "$CURR has changes"
		cp "$SRC" "$DEST"
	fi

done < collect-files

exit 0
