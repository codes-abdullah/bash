########################
#Watch specific files changes only in specific dir/*
#On changes, call function onFileChanges ${file_path} ${file_name} ${file_event};  
########################

#!/bin/bash



echo "##########################"
echo "started watching file changes ..[$$]"
echo "##########################"
let a=$(date +%s%N | cut -b1-13)
oldfile=""
let count=0
let timeout=1
inotifywait -r -m -e modify -e close_write -e move $1 --exclude "(font-awesome.*|WEB-INF\/lib.*)" |
#DO NOT WRITE ANY THING BETWEEN inotifywait COMMAND AND WHILE LOOP
while true
do
	#echo "watching.."
	changed=false
	while read -t $timeout file_path file_event file_name; do 
		############
		#Below code will invoke listener once every passed 5 seconds
		#but, the effect will not taken in place since this
		#will run on the first read
		#so will use read -t timeout to be able to exit the while loop
		#which will happen only when all read lines completed
		#so we can invoke listener after last read
		#############
	
	
		#let b=$(date +%s%N | cut -b1-13)
		#if [[ "$oldfile" == "${file_path}${file_name}" ]]; then
		#	continue;
		#else
		#	oldfile=${file_path}${file_name}
		#fi
		#if ((b - a >= 5000)); then
		#	echo "$((count))-###: $((_current - elipsed )): $file_event"
		#	let a=$(date +%s%N | cut -b1-13)
		#	let count=$((count+1))
		#	if [[ $(type -t onFileChanges) == function ]]; then 
		#		onFileChanges ${file_path} ${file_name} ${file_event} &
		#	fi
		#fi
		
		#echo ${file_path}${file_name} event: ${file_event}
		changed=true
	done
	
	#########
	#Invoke listener only after read all
	#########
	if [ "$changed" == true ]; then
		echo "$(date) - notified changes occurred !"
		if [[ $(type -t onFileChanges) == function ]]; then 
			onFileChanges ${file_path} ${file_name} ${file_event}
		fi
	fi
	
done
