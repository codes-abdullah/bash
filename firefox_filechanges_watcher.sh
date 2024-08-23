######################
#Firefox refresh current tab on file changes
######################

#!/bin/bash


function onFileChanges(){	
	/$LOCAL_BASH/firefox_tab_reloader.sh
}

source $LOCAL_BASH/watch.sh $1
