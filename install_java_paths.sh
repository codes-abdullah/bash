#!/bin/bash


jdk_dir="/home/abod/.local/bin/jdk"
linkpath="${jdk_dir}/default"
echo "avilable jdk's in ${jdk_dir}"
#========================
wild_dir="${jdk_dir}/*"
let index=0
declare -a arr
for path in $wild_dir; do
  dirname="${path##*/}"
  if ! [[ -L $path ]]; then
	echo "${index}: ${dirname}"
	index=$((index+1))
	arr=(${arr[@]} "$dirname")
  fi  
done
#========================
index=$((index-1))
echo "choose a number or q to exit:"
while read num
do

	if [[ "${num}" == "q" ]]; then
		echo "exiting.."
		exit
	fi
	
	let num=$num
	
	if [[ $num -lt 0 || $num -gt $index ]]; then 
		echo "invalid input, you've to choose from 0 to ${index}";
		continue;
	fi
	
	fullpath="${jdk_dir}/${arr[$num]}"

	break;
	
done < "${1:-/dev/stdin}"
#========================

function continue_or_exit(){
	read input
	if [[ $input == "q" ]]; then
		echo "exiting"	
		exit
	fi
}

function remove_link_if_exists(){
	if [[ -L $linkpath ]]; then
		rm $linkpath
	fi		
}


echo "======================"
echo "symbolic linking?"
echo "${linkpath} -> ${fullpath}"
echo -e "\nPress enter to continue or q to exit"
echo "======================"
remove_link_if_exists
continue_or_exit
ln -s "${fullpath}" "${linkpath}"

