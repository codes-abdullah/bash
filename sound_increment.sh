#!/bin/bash

RUN=true
trap ctrl_c INT

function ctrl_c(){
	RUN=false
}



let i=1;
for f in ./*; do

	if [[ "$RUN" = false ]]; then
		echo "trapping.."
		sleep 2s
		break;
	fi

	if ! test -f $f; then
		continue;		
	fi;
	

	if [[ "${f##*.}" != "mp4" ]]; then
		continue;
	fi
	
	echo ffmpeg -i $f -vcodec copy -filter:a "volume=5.000000" -max_muxing_queue_size 9999 "${f%.*}_$i.mp4"	
	ffmpeg -i $f -vcodec copy -filter:a "volume=5.000000" -max_muxing_queue_size 9999 "${f%.*}_$i.mp4"
	i=$(( i + 1))

done;


