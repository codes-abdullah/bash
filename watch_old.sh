#!/bin/bash

inotifywait -q -m -e close_write /home/abod/junk/ant/src/Main.java |
while read -r filename event; do
	#javap -v -p /home/abod/.local/bin/eclipse/jse-2006/workspace/J/bin/pkg/Chars.class
	echo "changes"
done
