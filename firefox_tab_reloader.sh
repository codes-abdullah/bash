######################
#Firefox refresh current tab from command-line
######################

#!/bin/bash

CURRENT_WID=$(xdotool getwindowfocus)

WID=$(xdotool search --name "Mozilla Firefox")
xdotool windowactivate $WID
xdotool key CTRL+F5

xdotool windowactivate $CURRENT_WID
