#!/bin/bash

installation_dir="/home/abod/.local/bin"
x1="${installation_dir}/*"


for app_dir in $x1; do
	x2="${app_dir}/*"
	for version_dir in $x2; do
		if [[ -d $version_dir ]]; then
			#not symbolic link
			if ! [[ -L $version_dir ]]; then
				#echo $version_dir
				echo ""
			fi
		fi
	done
done


function is_dir(){
	return true;
}


isit=`is_dir`
echo isit

