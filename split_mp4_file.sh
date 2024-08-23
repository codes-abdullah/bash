#!/bin/bash
# Short script to split videos by filesize using ffmpeg by LukeLR, modified by codes-abdullah to be faster and to support trapping with ctrl+c


#################
#usage example (original and very slow) (requires 3 args):
#./split_mp4_file.sh input.mp4 256000000 "-c:v libx264 -crf 23 -c:a copy -vf scale=960:-1"
#
#
#usage example (codes-abdullah@gmail.com and vert fast) (requires 2 args):
#./split_mp4_file.sh input.mp4 256000000
#
#the 256000000 represents the size in bytes
#################
if [ $# -ne 2 ]; then
    echo 'Illegal number of parameters. Needs 2 parameters:'
    echo 'Usage:'
    echo './split_mp4_file.sh FILE SIZELIMIT'
    echo 
    echo 'Parameters:'
    echo '    - FILE:        Name of the video file to split'
    echo '    - SIZELIMIT:   Maximum file size of each part (in bytes)'
    echo '    - FFMPEG_ARGS: Additional arguments to pass to each ffmpeg-call'
    echo '                   (video format and quality options etc.)'
    exit 1
fi

FILE="$1"
SIZELIMIT="$2"
FFMPEG_ARGS="$3"

# Duration of the source video
DURATION=$(ffprobe -i "$FILE" -show_entries format=duration -v quiet -of default=noprint_wrappers=1:nokey=1|cut -d. -f1)

# Duration that has been encoded so far
CUR_DURATION=0

# Filename of the source video (without extension)
BASENAME="${FILE%.*}"

# Extension for the video parts
#EXTENSION="${FILE##*.}"
EXTENSION="mp4"

# Number of the current video part
i=1

# Filename of the next video part
NEXTFILENAME="$BASENAME-$i.$EXTENSION"

echo "Duration of source video: $DURATION"

RUN=true
trap ctrl_c INT

function ctrl_c(){
	RUN=false;
}



# Until the duration of all partial videos has reached the duration of the source video
while [[ $CUR_DURATION -lt $DURATION ]]; do

	if [ "$RUN" = false ]; then
		echo "trapping..";
		sleep 2;
		break;
	fi

	# Encode next part
	
	
	#original
	#echo ffmpeg -i "$FILE" -ss "$CUR_DURATION" -fs "$SIZELIMIT" $FFMPEG_ARGS "$NEXTFILENAME"	
	#ffmpeg -ss "$CUR_DURATION" -i "$FILE" -fs "$SIZELIMIT" $FFMPEG_ARGS "$NEXTFILENAME"
	
	
	echo ffmpeg -ss "$CUR_DURATION" -i "$FILE" -fs "$SIZELIMIT" -map 0 -c copy  "$NEXTFILENAME"
	ffmpeg -ss "$CUR_DURATION" -i "$FILE" -fs "$SIZELIMIT" -map 0 -c copy  "$NEXTFILENAME"

	# Duration of the new part
	NEW_DURATION=$(ffprobe -i "$NEXTFILENAME" -show_entries format=duration -v quiet -of default=noprint_wrappers=1:nokey=1|cut -d. -f1)

	# Total duration encoded so far
	CUR_DURATION=$((CUR_DURATION + NEW_DURATION))

	i=$((i + 1))

	echo "Duration of $NEXTFILENAME: $NEW_DURATION"
	echo "Part No. $i starts at $CUR_DURATION"

	NEXTFILENAME="$BASENAME-$i.$EXTENSION"
	#if [[ "$i" -eq "3" ]]; then break; fi
done
